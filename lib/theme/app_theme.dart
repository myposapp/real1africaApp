import 'package:flutter/material.dart';

class AppTheme {
  // Brand Color Palette Tokens
  static const Color primaryTeal = Color(0xFF006767);
  static const Color primaryContainer = Color(0xFF008282);
  static const Color secondaryGold = Color(0xFFFABD32);
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);

  static ThemeData get lightTheme {
    final ColorScheme lightColorScheme = ColorScheme.fromSeed(
      seedColor: primaryTeal,
      brightness: Brightness.light,
      primary: primaryTeal,
      primaryContainer: const Color(0xFFCCECEC),
      secondary: const Color(0xFF705D00),
      secondaryContainer: const Color(0xFFFFE265),
      surface: const Color(0xFFF8F9FF),
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: const Color(0xFFEFF1F8),
      onSurface: const Color(0xFF191C1E),
      onSurfaceVariant: const Color(0xFF40484B),
      outlineVariant: const Color(0xFFC0C8CC),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      scaffoldBackgroundColor: lightColorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: lightColorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: lightColorScheme.onSurface),
        titleTextStyle: TextStyle(
          color: lightColorScheme.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: lightColorScheme.surfaceContainerLowest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: lightColorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: lightColorScheme.surfaceContainerLow,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        labelStyle: TextStyle(
          color: lightColorScheme.onSurface,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryTeal,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    final ColorScheme darkColorScheme = ColorScheme.fromSeed(
      seedColor: primaryTeal,
      brightness: Brightness.dark,
      primary: const Color(0xFF80D5D4),
      primaryContainer: primaryContainer,
      secondary: const Color(0xFFE5C333),
      secondaryContainer: const Color(0xFF534500),
      surface: darkBackground,
      surfaceContainerLowest: darkSurface,
      surfaceContainerLow: const Color(0xFF1B2333),
      onSurface: const Color(0xFFE1E2E5),
      onSurfaceVariant: const Color(0xFFA0AAB0),
      outlineVariant: const Color(0xFF40484C),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      scaffoldBackgroundColor: darkBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: darkBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: darkColorScheme.onSurface),
        titleTextStyle: TextStyle(
          color: darkColorScheme.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: darkColorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF1B2333),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        labelStyle: TextStyle(
          color: darkColorScheme.onSurface,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF008282),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ),
    );
  }
}
