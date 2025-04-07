import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/gif_gallery_page.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final themeIndex = prefs.getInt('themeMode') ?? ThemeMode.system.index;
  final initialThemeMode = ThemeMode.values[themeIndex];
  final contrastIndex = prefs.getInt('contrastLevel') ?? 2; // Default to high contrast
  final initialContrastLevel = contrastIndex;

  runApp(GifGalleryApp(initialThemeMode: initialThemeMode, initialContrastLevel: initialContrastLevel));
}

class GifGalleryApp extends StatefulWidget {
  final ThemeMode initialThemeMode;
  final int initialContrastLevel;

  const GifGalleryApp({super.key, required this.initialThemeMode, required this.initialContrastLevel});

  @override
  GifGalleryAppState createState() => GifGalleryAppState();
}

class GifGalleryAppState extends State<GifGalleryApp> {
  ThemeMode _themeMode;
  int _contrastLevel;

  GifGalleryAppState() : _themeMode = ThemeMode.system, _contrastLevel = 2;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
    _contrastLevel = widget.initialContrastLevel;
    _loadThemeMode();
    _loadContrastLevel();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('themeMode') ?? ThemeMode.system.index;
    final contrastIndex = prefs.getInt('contrastLevel') ?? 2;
    setState(() {
      _themeMode = ThemeMode.values[themeIndex];
      _contrastLevel = contrastIndex;
    });
  }

  Future<void> _saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', mode.index);
  }

  void _toggleThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
    _saveThemeMode(mode);
  }

  Future<void> _loadContrastLevel() async {
    final prefs = await SharedPreferences.getInstance();
    final contrastIndex = prefs.getInt('contrastLevel') ?? 2;
    setState(() {
      _contrastLevel = contrastIndex;
    });
  }

  Future<void> _saveContrastLevel(int level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('contrastLevel', level);
  }

  void _changeContrastLevel(int level) {
    setState(() {
      _contrastLevel = level;
    });
    _saveContrastLevel(level);
  }

  @override
  Widget build(BuildContext context) {
    final materialTheme = MaterialTheme(const TextTheme());
    final theme =
        _contrastLevel == 0
            ? materialTheme.light()
            : _contrastLevel == 1
            ? materialTheme.lightMediumContrast()
            : materialTheme.lightHighContrast();

    final darkTheme =
        _contrastLevel == 0
            ? materialTheme.dark()
            : _contrastLevel == 1
            ? materialTheme.darkMediumContrast()
            : materialTheme.darkHighContrast();

    return MaterialApp(
      title: 'Metrix Gallery',
      theme: theme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      home: GifGalleryPage(onThemeModeChanged: _toggleThemeMode, onContrastLevelChanged: _changeContrastLevel),
    );
  }
}
