import 'package:find_your_home_test/modules/auth/domain/entities/user.dart';
import 'package:find_your_home_test/modules/auth/domain/repositories/auth_repository.dart';

class RegisterUserUseCase {
  final AuthRepository repository;
  const RegisterUserUseCase(this.repository);

  Future<void> call({required String name, required String email, required String password}) async {
    // Validar nombre según requisitos: palabras separadas por un espacio, cada una con mayúscula inicial, sin espacios extra.
    final trimmed = name.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (trimmed.isEmpty) {
      throw ArgumentError('name_empty');
    }
    // Caracteres permitidos
    if (!_isValidName(trimmed)) {
      throw ArgumentError('name_format');
    }
    // Debe coincidir con su versión normalizada (capitalizada, sin espacios extra)
    final normalized = _normalizeName(trimmed);
    if (trimmed != normalized) {
      throw ArgumentError('name_format');
    }
    if (!_isValidEmail(email)) {
      throw ArgumentError('email_invalid');
    }
    if (password.length < 6) {
      throw ArgumentError('password_short');
    }

    final user = User(name: trimmed, email: email.trim().toLowerCase(), password: password);
    await repository.registerUser(user);
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return regex.hasMatch(email);
  }

  // Elimina espacios extra, capitaliza cada palabra (incluye partículas con guiones o apóstrofes)
  String _normalizeName(String input) {
    final trimmed = input.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (trimmed.isEmpty) return '';
    final parts = trimmed.split(' ');
    final capitalized = parts.map((p) => _capitalizeWord(p)).join(' ');
    return capitalized;
  }

  String _capitalizeWord(String word) {
    if (word.isEmpty) return word;
    // Manejar guiones y apóstrofes dentro de una “palabra”
    final separators = RegExp(r"[-']");
    return word.split(separators).map((seg) {
      if (seg.isEmpty) return seg;
      final lower = seg.toLowerCase();
      return lower[0].toUpperCase() + lower.substring(1);
    }).join(word.contains('-') ? '-' : (word.contains("'") ? "'" : ''));
  }

  // Debe ser solo letras (incluye acentos), espacios simples entre palabras, sin números ni símbolos
  bool _isValidName(String name) {
    // Comprobar que no hay dobles espacios (debe venir normalizado)
    if (name.contains('  ')) return false;
    final parts = name.split(' ');
    if (parts.any((p) => p.isEmpty)) return false;

    final allowed = RegExp(r"^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+(?:[-'][A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+)*$");
    for (final p in parts) {
      if (!allowed.hasMatch(p)) return false;
      final first = p[0];
      // Considerar mayúsculas con acentos/ñ
      if (first.toUpperCase() != first || first.toLowerCase() == first) {
        // Aseguramos que es letra y que está en mayúscula
        final isLetter = RegExp(r"[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]").hasMatch(first);
        if (!isLetter) return false;
        if (first != first.toUpperCase()) return false;
      }
    }
    return true;
  }
}
