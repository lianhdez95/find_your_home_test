// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Find Your Home';

  @override
  String get splashTagline => 'Find your ideal home';

  @override
  String get splashLoading => 'Loading...';

  @override
  String get splashTapToContinue => 'Tap to continue';

  @override
  String get splashSkip => 'Skip';

  @override
  String get loginWelcome => 'Welcome';

  @override
  String get loginSubtitle => 'Sign in to Find Your Home';

  @override
  String get loginEmailLabel => 'Email';

  @override
  String get registerNameLabel => 'Name';

  @override
  String get registerConfirmPasswordLabel => 'Confirm Password';

  @override
  String get registerNameHint => 'Your name';

  @override
  String get loginEmailHint => 'name@example.com';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginPasswordHint => 'Your password';

  @override
  String get loginButton => 'Sign In';

  @override
  String get loginRegisterCta => 'Don\'t have an account? Register';

  @override
  String get registerEmailLabel => 'Email';

  @override
  String get registerEmailHint => 'name@example.com';

  @override
  String get registerPasswordLabel => 'Password';

  @override
  String get registerPasswordHint => 'Your password';

  @override
  String get registerButton => 'Register';

  @override
  String get registerCta => 'Already have an account? Sign In';

  @override
  String get registerErrorEmailExists => 'Email is already registered';

  @override
  String get registerErrorEmailInvalid => 'Invalid email';

  @override
  String get registerErrorPasswordShort => 'Password is too short';

  @override
  String get registerErrorPasswordMismatch => 'Passwords do not match';

  @override
  String get registerErrorNameEmpty => 'Name is required';

  @override
  String get registerSuccess => 'Registration successful';

  @override
  String get registerErrorNameFormat => 'Invalid name format';

  @override
  String get loginErrorEmailInvalid => 'Invalid email';

  @override
  String get loginErrorPasswordEmpty => 'Password required';

  @override
  String get loginErrorUserNotFound => 'User not found';

  @override
  String get loginErrorInvalidCredentials => 'Invalid credentials';

  @override
  String get unexpectedError => 'Something went wrong';

  @override
  String get accept => 'Accept';

  @override
  String get cancel => 'Cancel';

  @override
  String get welcomeMessage => 'Welcome';

  @override
  String get exploreProperties => 'Explore properties';

  @override
  String get address => 'Address';

  @override
  String get description => 'Description';

  @override
  String get favorite => 'Favorite';
}
