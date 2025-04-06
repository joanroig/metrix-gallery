import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/gif_data.dart';
import 'filter_bar.dart';
import 'gif_grid.dart';

class GifGalleryPage extends StatefulWidget {
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const GifGalleryPage({super.key, required this.onThemeModeChanged});

  @override
  _GifGalleryPageState createState() => _GifGalleryPageState();
}

class _GifGalleryPageState extends State<GifGalleryPage> {
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

  @override
  void initState() {
    super.initState();
    _loadGifList();

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
  }

  @override
  void dispose() {
    minContrastController.dispose();
    maxContrastController.dispose();
    minContrastFocusNode.dispose();
    maxContrastFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadGifList() async {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Metrix Gallery (${filteredGifs.length} results)'),
        actions: [
          PopupMenuButton<ThemeMode>(
            onSelected: (ThemeMode mode) {
              widget.onThemeModeChanged(mode);
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(value: ThemeMode.system, child: Text('System Default')),
                  PopupMenuItem(value: ThemeMode.light, child: Text('Light Mode')),
                  PopupMenuItem(value: ThemeMode.dark, child: Text('Dark Mode')),
                ],
            icon: Icon(Icons.brightness_6),
          ),
        ],
      ),
      body: Column(
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
          Expanded(child: AnimatedSwitcher(duration: Duration(milliseconds: 300), child: GifGrid(gifs: filteredGifs))),
        ],
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
}
