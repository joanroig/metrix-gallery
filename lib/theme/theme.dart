import "package:flutter/material.dart";

// Generated with: https://material-foundation.github.io/material-theme-builder/
class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  // Normal contrast light scheme
  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff5d5f5f),
      surfaceTint: Color(0xff5d5f5f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffdfdfdf),
      onPrimaryContainer: Color(0xff616263),
      secondary: Color(0xff5e5e5e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffe4e2e2),
      onSecondaryContainer: Color(0xff656464),
      tertiary: Color(0xff605e5f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe3dee0),
      onTertiaryContainer: Color(0xff646263),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff1c1b1b),
      onSurfaceVariant: Color(0xff444748),
      outline: Color(0xff747878),
      outlineVariant: Color(0xffc4c7c8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffc6c6c6),
      primaryFixed: Color(0xffe2e2e2),
      onPrimaryFixed: Color(0xff1a1c1c),
      primaryFixedDim: Color(0xffc6c6c6),
      onPrimaryFixedVariant: Color(0xff454747),
      secondaryFixed: Color(0xffe4e2e2),
      onSecondaryFixed: Color(0xff1b1c1c),
      secondaryFixedDim: Color(0xffc8c6c6),
      onSecondaryFixedVariant: Color(0xff474747),
      tertiaryFixed: Color(0xffe6e1e3),
      onTertiaryFixed: Color(0xff1c1b1d),
      tertiaryFixedDim: Color(0xffcac5c7),
      onTertiaryFixedVariant: Color(0xff484648),
      surfaceDim: Color(0xffddd9d9),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  // Medium contrast light scheme with more distinct colors
  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff353637),
      surfaceTint: Color(0xff5d5f5f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6c6d6d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff363636),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6d6d6d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff373637),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6f6c6e),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff000000), // Darker text for more contrast
      onSurfaceVariant: Color(0xff2b2c2c), // Darker variant text
      outline: Color(0xff5a5e5e), // Darker outlines
      outlineVariant: Color(0xff7a7e7e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffc6c6c6),
      primaryFixed: Color(0xff48494a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff313333),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff494949),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff323333),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4b484a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff343234),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbbb8b7),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f0ef),
      surfaceContainer: Color(0xffe5e2e1),
      surfaceContainerHigh: Color(0xffd7d4d3),
      surfaceContainerHighest: Color(0xffc9c6c5),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  // High contrast light scheme with very distinct colors
  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff000000), // Black for maximum contrast
      surfaceTint: Color(0xff5d5f5f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff48494a),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2c2c2c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff494949),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2d2c2d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4b484a),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff000000), // Pure black text on light background
      onSurfaceVariant: Color(0xff000000), // Black variant text too
      outline: Color(0xff292d2d), // Very dark outlines
      outlineVariant: Color(0xff464a4a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffc6c6c6),
      primaryFixed: Color(0xff48494a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff313333),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff494949),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff323333),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4b484a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff343234),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbbb8b7),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f0ef),
      surfaceContainer: Color(0xffe5e2e1),
      surfaceContainerHigh: Color(0xffd7d4d3),
      surfaceContainerHighest: Color(0xffc9c6c5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  // Normal contrast dark scheme
  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffcfcfb),
      surfaceTint: Color(0xffc6c6c6),
      onPrimary: Color(0xff2f3131),
      primaryContainer: Color(0xffdfdfdf),
      onPrimaryContainer: Color(0xff616263),
      secondary: Color(0xffc8c6c6),
      onSecondary: Color(0xff303030),
      secondaryContainer: Color(0xff474747),
      onSecondaryContainer: Color(0xffb6b5b4),
      tertiary: Color(0xfffffbff),
      onTertiary: Color(0xff323032),
      tertiaryContainer: Color(0xffe3dee0),
      onTertiaryContainer: Color(0xff646263),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff141313),
      onSurface: Color(0xffe5e2e1),
      onSurfaceVariant: Color(0xffc4c7c8),
      outline: Color(0xff8e9192),
      outlineVariant: Color(0xff444748),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff5d5f5f),
      primaryFixed: Color(0xffe2e2e2),
      onPrimaryFixed: Color(0xff1a1c1c),
      primaryFixedDim: Color(0xffc6c6c6),
      onPrimaryFixedVariant: Color(0xff454747),
      secondaryFixed: Color(0xffe4e2e2),
      onSecondaryFixed: Color(0xff1b1c1c),
      secondaryFixedDim: Color(0xffc8c6c6),
      onSecondaryFixedVariant: Color(0xff474747),
      tertiaryFixed: Color(0xffe6e1e3),
      onTertiaryFixed: Color(0xff1c1b1d),
      tertiaryFixedDim: Color(0xffcac5c7),
      onTertiaryFixedVariant: Color(0xff484648),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  // Medium contrast dark scheme with more distinct colors
  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffcfcfb),
      surfaceTint: Color(0xffc6c6c6),
      onPrimary: Color(0xff2f3131),
      primaryContainer: Color(0xffdfdfdf),
      onPrimaryContainer: Color(0xff454646),
      secondary: Color(0xffdedcdb),
      onSecondary: Color(0xff252626),
      secondaryContainer: Color(0xff919090),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffffbff),
      onTertiary: Color(0xff323032),
      tertiaryContainer: Color(0xffe3dee0),
      onTertiaryContainer: Color(0xff484547),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff), // Pure white text on dark background
      onSurfaceVariant: Color(0xffdadddd), // Lighter variant text
      outline: Color(0xffcacecf), // Much brighter outlines for contrast
      outlineVariant: Color(0xff8d9191),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff474848),
      primaryFixed: Color(0xffe2e2e2),
      onPrimaryFixed: Color(0xff101112),
      primaryFixedDim: Color(0xffc6c6c6),
      onPrimaryFixedVariant: Color(0xff353637),
      secondaryFixed: Color(0xffe4e2e2),
      onSecondaryFixed: Color(0xff111111),
      secondaryFixedDim: Color(0xffc8c6c6),
      onSecondaryFixedVariant: Color(0xff363636),
      tertiaryFixed: Color(0xffe6e1e3),
      onTertiaryFixed: Color(0xff121112),
      tertiaryFixedDim: Color(0xffcac5c7),
      onTertiaryFixedVariant: Color(0xff373637),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff454444),
      surfaceContainerLowest: Color(0xff070707),
      surfaceContainerLow: Color(0xff1e1d1d),
      surfaceContainer: Color(0xff282828),
      surfaceContainerHigh: Color(0xff333232),
      surfaceContainerHighest: Color(0xff3e3d3d),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  // High contrast dark scheme with very distinct colors
  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffffff), // Pure white for maximum contrast
      surfaceTint: Color(0xffc6c6c6),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffdfdfdf),
      onPrimaryContainer: Color(0xff262828),
      secondary: Color(0xfff2efef),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc4c2c2),
      onSecondaryContainer: Color(0xff0b0b0b),
      tertiary: Color(0xfffffbff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffe3dee0),
      onTertiaryContainer: Color(0xff292729),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff141313), // Keep dark background
      onSurface: Color(0xffffffff), // Pure white text for maximum contrast
      onSurfaceVariant: Color(0xffffffff), // Also white variant text
      outline: Color(0xffeef0f1), // Very bright outlines
      outlineVariant: Color(0xffc0c3c4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff474848),
      primaryFixed: Color(0xffe2e2e2),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffc6c6c6),
      onPrimaryFixedVariant: Color(0xff101112),
      secondaryFixed: Color(0xffe4e2e2),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc8c6c6),
      onSecondaryFixedVariant: Color(0xff111111),
      tertiaryFixed: Color(0xffe6e1e3),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffcac5c7),
      onTertiaryFixedVariant: Color(0xff121112),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff51504f),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff201f1f),
      surfaceContainer: Color(0xff313030),
      surfaceContainerHigh: Color(0xff3c3b3b),
      surfaceContainerHighest: Color(0xff484646),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(bodyColor: colorScheme.onSurface, displayColor: colorScheme.onSurface),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({required this.color, required this.onColor, required this.colorContainer, required this.onColorContainer});

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
