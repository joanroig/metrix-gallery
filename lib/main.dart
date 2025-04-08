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

// Class to hold theme settings that can be passed down the widget tree
class ThemeSettings {
  final ThemeMode themeMode;
  final int contrastLevel;

  const ThemeSettings({required this.themeMode, required this.contrastLevel});
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

  GifGalleryAppState() : _themeMode = ThemeMode.system, _contrastLevel = 1;

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
    final contrastIndex = prefs.getInt('contrastLevel') ?? 1;
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
    final contrastIndex = prefs.getInt('contrastLevel') ?? 1;
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

    // Ensure theme changes when contrast level changes
    ThemeData lightTheme;
    ThemeData darkTheme;

    switch (_contrastLevel) {
      case 0:
        lightTheme = materialTheme.light();
        darkTheme = materialTheme.dark();
        break;
      case 1:
        lightTheme = materialTheme.lightMediumContrast();
        darkTheme = materialTheme.darkMediumContrast();
        break;
      case 2:
      default:
        lightTheme = materialTheme.lightHighContrast();
        darkTheme = materialTheme.darkHighContrast();
        break;
    }

    // Create ThemeSettings object to pass to child components
    final themeSettings = ThemeSettings(themeMode: _themeMode, contrastLevel: _contrastLevel);

    return MaterialApp(
      title: 'Metrix Gallery',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      home: GifGalleryPage(onThemeModeChanged: _toggleThemeMode, onContrastLevelChanged: _changeContrastLevel, themeSettings: themeSettings),
    );
  }
}
