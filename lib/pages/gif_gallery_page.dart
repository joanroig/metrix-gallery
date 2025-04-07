import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/gif_data.dart';
import '../widgets/filter_bar.dart';
import '../widgets/gif_grid.dart';

class GifGalleryPage extends StatefulWidget {
  final void Function(ThemeMode) onThemeModeChanged;
  final void Function(int) onContrastLevelChanged;

  const GifGalleryPage({super.key, required this.onThemeModeChanged, required this.onContrastLevelChanged});

  @override
  GifGalleryPageState createState() => GifGalleryPageState();
}

class GifGalleryPageState extends State<GifGalleryPage> {
  List<GifData> allGifs = [];
  List<GifData> filteredGifs = [];

  String? selectedBgColor = 'All';
  String? selectedTextColor = 'All';
  String? selectedType = 'All';
  String? selectedSortOption = 'Random';

  double minContrast = 6.00;
  double maxContrast = 8.00;

  Set<String> bgColors = {};
  Set<String> textColors = {};
  Set<String> types = {};

  late TextEditingController minContrastController;
  late TextEditingController maxContrastController;

  late FocusNode minContrastFocusNode;
  late FocusNode maxContrastFocusNode;

  bool _isAppIconLoaded = false;

  @override
  void initState() {
    super.initState();

    minContrastController = TextEditingController(text: minContrast.toStringAsFixed(2));
    maxContrastController = TextEditingController(text: maxContrast.toStringAsFixed(2));

    minContrastFocusNode = FocusNode();
    maxContrastFocusNode = FocusNode();

    minContrastFocusNode.addListener(() {
      if (!minContrastFocusNode.hasFocus) {
        _applyMinContrast();
      }
    });

    maxContrastFocusNode.addListener(() {
      if (!maxContrastFocusNode.hasFocus) {
        _applyMaxContrast();
      }
    });

    // Load the app icon first, then load GIFs
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp().then((_) {
        setState(() {
          _isAppIconLoaded = true;
        });
        _loadGifListAsync();
      });
    });
  }

  Future<void> _initializeApp() async {
    await _precacheAppIcon();
  }

  Future<void> _loadGifListAsync() async {
    await Future.delayed(Duration.zero); // Yield to the event loop
    final jsonStr = await rootBundle.loadString('assets/gifs.json');
    final List<dynamic> files = json.decode(jsonStr);

    final gifs = files.map((path) => GifData.fromJson(path)).toList();

    setState(() {
      allGifs = gifs;
      bgColors = allGifs.map((g) => g.bgColor).toSet();
      textColors = allGifs.map((g) => g.textColor).toSet();
      types = allGifs.expand((g) => g.types).toSet();
      _applyFilters();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheAppIcon();
  }

  @override
  void dispose() {
    minContrastController.dispose();
    maxContrastController.dispose();
    minContrastFocusNode.dispose();
    maxContrastFocusNode.dispose();
    super.dispose();
  }

  void _applyFilters() {
    setState(() {
      filteredGifs =
          allGifs.where((gif) {
            final matchesBg = selectedBgColor == 'All' || gif.bgColor == selectedBgColor;
            final matchesText = selectedTextColor == 'All' || gif.textColor == selectedTextColor;
            final matchesType = selectedType == 'All' || gif.types.contains(selectedType);
            final matchesContrast = gif.contrast >= minContrast && gif.contrast <= maxContrast;
            return matchesBg && matchesText && matchesType && matchesContrast;
          }).toList();
      _sortGifs();
    });
  }

  void _sortGifs() {
    if (selectedSortOption == 'Alphabetical by Background') {
      filteredGifs.sort((a, b) => a.bgColor.compareTo(b.bgColor));
    } else if (selectedSortOption == 'Alphabetical by Text') {
      filteredGifs.sort((a, b) => a.textColor.compareTo(b.textColor));
    } else if (selectedSortOption == 'Random') {
      filteredGifs.shuffle();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final appIcon = isDarkMode ? 'assets/icons/app_icon_dark.png' : 'assets/icons/app_icon_light.png';

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 100),
              child:
                  _isAppIconLoaded
                      ? Image.asset(appIcon, height: 24, key: ValueKey(appIcon))
                      : SizedBox(height: 24, width: 24, key: ValueKey('placeholderIcon')),
            ),
            SizedBox(width: 8),
            Text('Metrix Gallery (${filteredGifs.length} results)'),
            Spacer(),
            IconButton(
              icon: Icon(isDarkMode ? Icons.brightness_4_sharp : Icons.brightness_7),
              onPressed: () async {
                final selectedMode = await showMenu<dynamic>(
                  context: context,
                  position: RelativeRect.fromLTRB(1000, 56, 0, 0),
                  items: [
                    PopupMenuItem(value: ThemeMode.system, child: Text('System Default')),
                    PopupMenuItem(value: ThemeMode.light, child: Text('Light Mode')),
                    PopupMenuItem(value: ThemeMode.dark, child: Text('Dark Mode')),
                    PopupMenuDivider(),
                    PopupMenuItem(value: 0, child: Row(children: [Icon(Icons.brightness_low_sharp), SizedBox(width: 8), Text('Normal Contrast')])),
                    PopupMenuItem(value: 1, child: Row(children: [Icon(Icons.brightness_6_sharp), SizedBox(width: 8), Text('Medium Contrast')])),
                    PopupMenuItem(value: 2, child: Row(children: [Icon(Icons.brightness_high_sharp), SizedBox(width: 8), Text('High Contrast')])),
                  ],
                );

                if (selectedMode is ThemeMode) {
                  widget.onThemeModeChanged(selectedMode);
                } else if (selectedMode is int) {
                  widget.onContrastLevelChanged(selectedMode);
                }
              },
            ),
          ],
        ),
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child:
            _isAppIconLoaded
                ? Column(
                  key: ValueKey('contentLoaded'),
                  children: [
                    FilterBar(
                      selectedBgColor: selectedBgColor,
                      selectedTextColor: selectedTextColor,
                      selectedType: selectedType,
                      selectedSortOption: selectedSortOption,
                      minContrast: minContrast,
                      maxContrast: maxContrast,
                      bgColors: bgColors,
                      textColors: textColors,
                      types: types,
                      minContrastController: minContrastController,
                      maxContrastController: maxContrastController,
                      onBgColorChanged: (val) {
                        setState(() {
                          selectedBgColor = val;
                          _applyFilters();
                        });
                      },
                      onTextColorChanged: (val) {
                        setState(() {
                          selectedTextColor = val;
                          _applyFilters();
                        });
                      },
                      onTypeChanged: (val) {
                        setState(() {
                          selectedType = val;
                          _applyFilters();
                        });
                      },
                      onSortOptionChanged: (val) {
                        setState(() {
                          selectedSortOption = val;
                          _applyFilters();
                        });
                      },
                      onResetFilters: () {
                        setState(() {
                          selectedBgColor = 'All';
                          selectedTextColor = 'All';
                          selectedType = 'All';
                          selectedSortOption = 'Random';
                          minContrast = 6.00;
                          maxContrast = 8.00;
                          _applyFilters();
                        });
                      },
                      onContrastChanged: (values) {
                        setState(() {
                          minContrast = values.start;
                          maxContrast = values.end;
                          minContrastController.text = minContrast.toStringAsFixed(2);
                          maxContrastController.text = maxContrast.toStringAsFixed(2);
                          _applyFilters();
                        });
                      },
                    ),
                    Expanded(
                      child: AnimatedSwitcher(duration: Duration(milliseconds: 300), child: GifGrid(gifs: filteredGifs, key: ValueKey('gifGrid'))),
                    ),
                  ],
                )
                : Center(key: ValueKey('loadingIndicator'), child: CircularProgressIndicator()),
      ),
    );
  }

  void _applyMinContrast() {
    setState(() {
      final parsedValue = double.tryParse(minContrastController.text);
      if (parsedValue != null && parsedValue >= 1.00 && parsedValue <= maxContrast) {
        minContrast = parsedValue;
      } else {
        minContrastController.text = minContrast.toStringAsFixed(2);
      }
      _applyFilters();
    });
  }

  void _applyMaxContrast() {
    setState(() {
      final parsedValue = double.tryParse(maxContrastController.text);
      if (parsedValue != null && parsedValue <= 21.00 && parsedValue >= minContrast) {
        maxContrast = parsedValue;
      } else {
        maxContrastController.text = maxContrast.toStringAsFixed(2);
      }
      _applyFilters();
    });
  }

  Future<void> _precacheAppIcon() async {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final appIcon = isDarkMode ? 'assets/icons/app_icon_dark.png' : 'assets/icons/app_icon_light.png';
    await precacheImage(AssetImage(appIcon), context);
  }
}
