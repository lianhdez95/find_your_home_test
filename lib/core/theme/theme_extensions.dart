import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Extensiones para facilitar el uso del tema en la aplicación
extension AppThemeExtension on BuildContext {
  /// Obtiene el tema actual
  ThemeData get theme => Theme.of(this);
  
  /// Obtiene el esquema de colores actual
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  
  /// Obtiene el tema de texto actual
  TextTheme get textTheme => Theme.of(this).textTheme;
  
  /// Verifica si el tema actual es oscuro
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;
  
  /// Obtiene un color personalizado del tema
  Color getCustomColor(String colorName) => AppTheme.getCustomColor(colorName);
}

/// Extensiones para colores específicos
extension AppColorsExtension on BuildContext {
  /// Color primario azul
  Color get primaryBlue => getCustomColor('primaryBlue');
  
  /// Color azul claro
  Color get lightBlue => getCustomColor('lightBlue');
  
  /// Color azul medio
  Color get mediumBlue => getCustomColor('mediumBlue');
  
  /// Color azul de acento
  Color get accentBlue => getCustomColor('accentBlue');
  
  /// Color de éxito
  Color get successColor => getCustomColor('success');
  
  /// Color de advertencia
  Color get warningColor => getCustomColor('warning');
  
  /// Color de error
  Color get errorColor => getCustomColor('error');
  
  /// Color de información
  Color get infoColor => getCustomColor('info');
}

/// Extensiones para facilitar el uso de estilos de texto
extension TextStyleExtension on BuildContext {
  /// Título grande
  TextStyle get displayLarge => textTheme.displayLarge!;
  
  /// Título medio
  TextStyle get displayMedium => textTheme.displayMedium!;
  
  /// Título pequeño
  TextStyle get displaySmall => textTheme.displaySmall!;
  
  /// Encabezado grande
  TextStyle get headlineLarge => textTheme.headlineLarge!;
  
  /// Encabezado medio
  TextStyle get headlineMedium => textTheme.headlineMedium!;
  
  /// Encabezado pequeño
  TextStyle get headlineSmall => textTheme.headlineSmall!;
  
  /// Título grande
  TextStyle get titleLarge => textTheme.titleLarge!;
  
  /// Título medio
  TextStyle get titleMedium => textTheme.titleMedium!;
  
  /// Título pequeño
  TextStyle get titleSmall => textTheme.titleSmall!;
  
  /// Cuerpo grande
  TextStyle get bodyLarge => textTheme.bodyLarge!;
  
  /// Cuerpo medio
  TextStyle get bodyMedium => textTheme.bodyMedium!;
  
  /// Cuerpo pequeño
  TextStyle get bodySmall => textTheme.bodySmall!;
  
  /// Etiqueta grande
  TextStyle get labelLarge => textTheme.labelLarge!;
  
  /// Etiqueta media
  TextStyle get labelMedium => textTheme.labelMedium!;
  
  /// Etiqueta pequeña
  TextStyle get labelSmall => textTheme.labelSmall!;
}

/// Widget helper para espaciado
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  
  /// SizedBox con altura
  static Widget verticalSpace(double height) => SizedBox(height: height);
  
  /// SizedBox con ancho
  static Widget horizontalSpace(double width) => SizedBox(width: width);
  
  /// Espacios predefinidos verticales
  static Widget get verticalXS => verticalSpace(xs);
  static Widget get verticalSM => verticalSpace(sm);
  static Widget get verticalMD => verticalSpace(md);
  static Widget get verticalLG => verticalSpace(lg);
  static Widget get verticalXL => verticalSpace(xl);
  static Widget get verticalXXL => verticalSpace(xxl);
  
  /// Espacios predefinidos horizontales
  static Widget get horizontalXS => horizontalSpace(xs);
  static Widget get horizontalSM => horizontalSpace(sm);
  static Widget get horizontalMD => horizontalSpace(md);
  static Widget get horizontalLG => horizontalSpace(lg);
  static Widget get horizontalXL => horizontalSpace(xl);
  static Widget get horizontalXXL => horizontalSpace(xxl);
}

/// Border radius predefinidos
class AppBorderRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double circle = 999.0;
  
  static BorderRadius get small => BorderRadius.circular(sm);
  static BorderRadius get medium => BorderRadius.circular(md);
  static BorderRadius get large => BorderRadius.circular(lg);
  static BorderRadius get extraLarge => BorderRadius.circular(xl);
  static BorderRadius get circular => BorderRadius.circular(circle);
}

/// Sombras predefinidas
class AppShadows {
  static List<BoxShadow> get light => [
    BoxShadow(
      color: Colors.black.withAlpha(100),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];
  
  static List<BoxShadow> get medium => [
    BoxShadow(
      color: Colors.black.withAlpha(150),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> get heavy => [
    BoxShadow(
      color: Colors.black.withAlpha(200),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];
}