import 'package:flutter/material.dart';

import 'pages/gif_gallery_page.dart';

void main() {
  runApp(GifGalleryApp());
}

class GifGalleryApp extends StatefulWidget {
  const GifGalleryApp({super.key});

  @override
  _GifGalleryAppState createState() => _GifGalleryAppState();
}

class _GifGalleryAppState extends State<GifGalleryApp> {
  ThemeMode _themeMode = ThemeMode.system; // Default to device settings

  void _toggleThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GIF Gallery',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: GifGalleryPage(onThemeModeChanged: _toggleThemeMode),
    );
  }
}
