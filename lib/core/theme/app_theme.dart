import 'package:flutter/material.dart';

class AppTheme {
  // Colores principales - Paleta azul
  static const Color _primaryBlue = Color(0xFF1976D2);
  static const Color _primaryDarkBlue = Color(0xFF0D47A1);
  static const Color _accentBlue = Color(0xFF2196F3);
  static const Color _lightBlue = Color(0xFFE3F2FD);
  static const Color _mediumBlue = Color(0xFF90CAF9);
  
  // Colores secundarios
  static const Color _secondaryBlue = Color(0xFF03DAC6);
  static const Color _secondaryLightBlue = Color(0xFF4EECD9);
  static const Color _secondaryDarkBlue = Color(0xFF018786);
  
  // Colores neutrales
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _lightGray = Color(0xFFF5F5F5);
  static const Color _mediumGray = Color(0xFFE0E0E0);
  static const Color _darkGray = Color(0xFF424242);
  static const Color _black = Color(0xFF000000);
  
  // Colores para estados
  static const Color _success = Color(0xFF4CAF50);
  static const Color _warning = Color(0xFFFF9800);
  static const Color _error = Color(0xFFF44336);
  static const Color _info = Color(0xFF2196F3);

  // Typography
  static const String _fontFamily = 'Rubik';

  // Theme para modo claro
  static ThemeData get lightTheme {
    final base = ThemeData(
      brightness: Brightness.light,
      fontFamily: _fontFamily,
      primarySwatch: Colors.blue,
      useMaterial3: true,
      
      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: _primaryBlue,
        primaryContainer: _lightBlue,
        secondary: _secondaryBlue,
        secondaryContainer: _secondaryLightBlue,
        surface: _white,
        surfaceContainerHighest: _lightGray,
        error: _error,
        onPrimary: _white,
        onSecondary: _black,
        onSurface: _black,
        onError: _white,
        outline: _mediumGray,
        shadow: Colors.black26,
      ),

      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: _primaryBlue,
        foregroundColor: _white,
        elevation: 2,
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: _white,
        ),
        iconTheme: IconThemeData(color: _white),
      ),

      // Elevated Button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryBlue,
          foregroundColor: _white,
          elevation: 2,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      // Outlined Button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _primaryBlue,
          side: const BorderSide(color: _primaryBlue, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      // Text Button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _primaryBlue,
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),

      // Input Decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _lightGray,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _mediumGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _mediumGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _error, width: 2),
        ),
        labelStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: _darkGray,
        ),
        hintStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: _darkGray,
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: _white,
        elevation: 2,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: _mediumGray,
        thickness: 1,
      ),

      // Text theme
      textTheme: _baseTextThemeLight,
    );
    return base;
  }

  // Theme para modo oscuro
  static ThemeData get darkTheme {
    final base = ThemeData(
      brightness: Brightness.dark,
      fontFamily: _fontFamily,
      primarySwatch: Colors.blue,
      useMaterial3: true,
      
      // Color scheme
      colorScheme: const ColorScheme.dark(
        primary: _mediumBlue,
        primaryContainer: _primaryDarkBlue,
        secondary: _secondaryBlue,
        secondaryContainer: _secondaryDarkBlue,
        surface: Color(0xFF121212),
        surfaceContainerHighest: Color(0xFF1E1E1E),
        error: _error,
        onPrimary: _black,
        onSecondary: _black,
        onSurface: _white,
        onError: _white,
        outline: Color(0xFF424242),
        shadow: Colors.black54,
      ),

      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E1E1E),
        foregroundColor: _white,
        elevation: 2,
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: _white,
        ),
        iconTheme: IconThemeData(color: _white),
      ),

      // Elevated Button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _mediumBlue,
          foregroundColor: _black,
          elevation: 2,
          shadowColor: Colors.black54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      // Outlined Button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _mediumBlue,
          side: const BorderSide(color: _mediumBlue, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      // Text Button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _mediumBlue,
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),

      // Input Decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF424242)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF424242)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _mediumBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _error, width: 2),
        ),
        labelStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: Color(0xFFBDBDBD),
        ),
        hintStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: Color(0xFF757575),
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: const Color(0xFF1E1E1E),
        elevation: 2,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: Color(0xFF424242),
        thickness: 1,
      ),

      // Text theme
      textTheme: _baseTextThemeDark,
    );
    return base;
  }

  // Colores personalizados adicionales
  static const Map<String, Color> customColors = {
    'success': _success,
    'warning': _warning,
    'error': _error,
    'info': _info,
    'primaryBlue': _primaryBlue,
    'lightBlue': _lightBlue,
    'mediumBlue': _mediumBlue,
    'accentBlue': _accentBlue,
  };

  // Método para obtener colores personalizados
  static Color getCustomColor(String colorName) {
    return customColors[colorName] ?? _primaryBlue;
  }
}

// ---------------- Responsive Typography Support ----------------

// Definimos tamaños base (design tokens) sin escalar; se escalarán en runtime.
const TextTheme _baseTextThemeLight = TextTheme(
  displayLarge: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 34, fontWeight: FontWeight.w700, color: AppTheme._black),
  displayMedium: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 30, fontWeight: FontWeight.w600, color: AppTheme._black),
  displaySmall: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 26, fontWeight: FontWeight.w600, color: AppTheme._black),
  headlineLarge: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 24, fontWeight: FontWeight.w600, color: AppTheme._black),
  headlineMedium: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 22, fontWeight: FontWeight.w600, color: AppTheme._black),
  headlineSmall: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 20, fontWeight: FontWeight.w600, color: AppTheme._black),
  titleLarge: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme._black),
  titleMedium: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 16, fontWeight: FontWeight.w500, color: AppTheme._black),
  titleSmall: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme._black),
  bodyLarge: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 16, fontWeight: FontWeight.w400, color: AppTheme._black),
  bodyMedium: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 14, fontWeight: FontWeight.w400, color: AppTheme._black),
  bodySmall: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 12, fontWeight: FontWeight.w400, color: AppTheme._darkGray),
  labelLarge: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme._black),
  labelMedium: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 12, fontWeight: FontWeight.w500, color: AppTheme._darkGray),
  labelSmall: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 11, fontWeight: FontWeight.w500, color: AppTheme._darkGray),
);

const TextTheme _baseTextThemeDark = TextTheme(
  displayLarge: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 34, fontWeight: FontWeight.w700, color: AppTheme._white),
  displayMedium: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 30, fontWeight: FontWeight.w600, color: AppTheme._white),
  displaySmall: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 26, fontWeight: FontWeight.w600, color: AppTheme._white),
  headlineLarge: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 24, fontWeight: FontWeight.w600, color: AppTheme._white),
  headlineMedium: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 22, fontWeight: FontWeight.w600, color: AppTheme._white),
  headlineSmall: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 20, fontWeight: FontWeight.w600, color: AppTheme._white),
  titleLarge: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme._white),
  titleMedium: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 16, fontWeight: FontWeight.w500, color: AppTheme._white),
  titleSmall: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme._white),
  bodyLarge: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 16, fontWeight: FontWeight.w400, color: AppTheme._white),
  bodyMedium: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 14, fontWeight: FontWeight.w400, color: AppTheme._white),
  bodySmall: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFFBDBDBD)),
  labelLarge: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme._white),
  labelMedium: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFFBDBDBD)),
  labelSmall: TextStyle(fontFamily: AppTheme._fontFamily, fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFFBDBDBD)),
);

/// Escala un TextTheme según ancho, alto y factor de accesibilidad del usuario.
/// Base width de referencia: 390 (iPhone 14). Limita escalado para evitar excesos.
TextTheme scaleTextTheme(BuildContext context, TextTheme original) {
  final media = MediaQuery.of(context);
  final width = media.size.width;
  final height = media.size.height;
  final textScale = media.textScaleFactor; // accesibilidad del sistema

  // Factor basado en ancho y altura (peso mayor al ancho).
  final widthFactor = (width / 390).clamp(0.85, 1.25);
  final heightFactor = (height / 844).clamp(0.9, 1.15);
  final deviceFactor = ((widthFactor * 0.65) + (heightFactor * 0.35));

  // Factor final combinando accesibilidad pero suavizado para no duplicar.
  final finalFactor = (deviceFactor * (0.5 + (textScale * 0.5))).clamp(0.85, 1.35);

  TextStyle? scale(TextStyle? style) {
    if (style == null) return null;
    return style.copyWith(fontSize: (style.fontSize ?? 14) * finalFactor);
  }

  return TextTheme(
    displayLarge: scale(original.displayLarge),
    displayMedium: scale(original.displayMedium),
    displaySmall: scale(original.displaySmall),
    headlineLarge: scale(original.headlineLarge),
    headlineMedium: scale(original.headlineMedium),
    headlineSmall: scale(original.headlineSmall),
    titleLarge: scale(original.titleLarge),
    titleMedium: scale(original.titleMedium),
    titleSmall: scale(original.titleSmall),
    bodyLarge: scale(original.bodyLarge),
    bodyMedium: scale(original.bodyMedium),
    bodySmall: scale(original.bodySmall),
    labelLarge: scale(original.labelLarge),
    labelMedium: scale(original.labelMedium),
    labelSmall: scale(original.labelSmall),
  );
}
