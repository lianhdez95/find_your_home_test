// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Encuentra Tu Hogar';

  @override
  String get splashTagline => 'Encuentra tu hogar ideal';

  @override
  String get splashLoading => 'Cargando...';

  @override
  String get splashTapToContinue => 'Toca para continuar';

  @override
  String get splashSkip => 'Saltar';

  @override
  String get loginWelcome => 'Bienvenido';

  @override
  String get loginSubtitle => 'Inicia sesión en Find Your Home';

  @override
  String get loginEmailLabel => 'Email';

  @override
  String get registerNameLabel => 'Nombre';

  @override
  String get registerConfirmPasswordLabel => 'Confirmar Contraseña';

  @override
  String get registerNameHint => 'Tu nombre';

  @override
  String get loginEmailHint => 'correo@ejemplo.com';

  @override
  String get loginPasswordLabel => 'Contraseña';

  @override
  String get loginPasswordHint => 'Tu contraseña';

  @override
  String get loginButton => 'Iniciar Sesión';

  @override
  String get loginRegisterCta => '¿No tienes cuenta? Regístrate';

  @override
  String get registerEmailLabel => 'Email';

  @override
  String get registerEmailHint => 'correo@ejemplo.com';

  @override
  String get registerPasswordLabel => 'Contraseña';

  @override
  String get registerPasswordHint => 'Tu contraseña';

  @override
  String get registerButton => 'Registrarse';

  @override
  String get registerCta => '¿Ya tienes cuenta? Inicia sesión';

  @override
  String get registerErrorEmailExists => 'Email ya registrado';

  @override
  String get registerErrorEmailInvalid => 'Email inválido';

  @override
  String get registerErrorPasswordShort => 'La contraseña es muy corta';

  @override
  String get registerErrorPasswordMismatch => 'Las contraseñas no coinciden';

  @override
  String get registerErrorNameEmpty => 'El nombre es obligatorio';

  @override
  String get registerSuccess => 'Registro exitoso';

  @override
  String get registerErrorNameFormat => 'Formato de nombre inválido';

  @override
  String get loginErrorEmailInvalid => 'Email inválido';

  @override
  String get loginErrorPasswordEmpty => 'Contraseña requerida';

  @override
  String get loginErrorUserNotFound => 'Usuario no encontrado';

  @override
  String get loginErrorInvalidCredentials => 'Credenciales inválidas';

  @override
  String get unexpectedError => 'Algo salió mal';

  @override
  String get accept => 'Aceptar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get welcomeMessage => 'Bienvenido';

  @override
  String get exploreProperties => 'Explora propiedades';

  @override
  String get address => 'Dirección';

  @override
  String get description => 'Descripción';

  @override
  String get favorite => 'Favorito';

  @override
  String get find_header => 'Escribe el nombre o ciudad del inmueble';

  @override
  String get find_center => 'Escribe algo para buscar';

  @override
  String get no_results => 'No se encontraron resultados';

  @override
  String get searching => 'Buscando...';
}
