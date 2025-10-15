import 'package:find_your_home_test/core/theme/theme_extensions.dart';
import 'package:find_your_home_test/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;
  final VoidCallback? onLoginTap;
  final VoidCallback onSubmit;
  final bool isSubmitting;
  final String? errorCode; // para mostrar email_exists
  final String password; // para validar confirmación
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPasswordChanged;
  final ValueChanged<String> onConfirmChanged;

  const RegisterView({
    super.key,
    required this.formKey,
    required this.autovalidateMode,
    required this.onSubmit,
    required this.isSubmitting,
    required this.password,
    required this.onNameChanged,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.onConfirmChanged,
    this.onLoginTap,
    this.errorCode,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.15,
                child: Image.asset('assets/images/app_logo.png'),
              ),
              AppSpacing.horizontalMD,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.loginWelcome,
                    style: context.displayMedium.copyWith(color: context.primaryBlue),
                    textAlign: TextAlign.center,
                  ),
                  AppSpacing.verticalSM,
                  Text(
                    l10n.loginSubtitle,
                    style: context.bodyLarge.copyWith(color: context.colorScheme.onSurface.withAlpha(170)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          AppSpacing.verticalXL,
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: onNameChanged,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return l10n.registerErrorNameEmpty;
                      final trimmed = v.trim().replaceAll(RegExp(r'\s+'), ' ');
                      // Normalizar (capitalizar) para comparar
                      String normalizeWord(String w) {
                        final sep = RegExp(r"[-']");
                        return w
                            .split(sep)
                            .map((seg) => seg.isEmpty ? seg : seg[0].toUpperCase() + seg.substring(1).toLowerCase())
                            .join(w.contains('-') ? '-' : (w.contains("'") ? "'" : ''));
                      }
                      final parts = trimmed.split(' ');
                      final normalized = parts.map(normalizeWord).join(' ');
                      if (trimmed != normalized) return l10n.registerErrorNameFormat;
                      // Además, validar caracteres permitidos
                      final allowed = RegExp(r"^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+(?:[-'][A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+)*$");
                      for (final p in parts) {
                        if (!allowed.hasMatch(p)) return l10n.registerErrorNameFormat;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: l10n.registerNameLabel,
                      hintText: l10n.registerNameHint,
                      prefixIcon: const Icon(Icons.person_2_outlined),
                    ),
                  ),
                  AppSpacing.verticalMD,
                  TextFormField(
                    onChanged: onEmailChanged,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return l10n.registerErrorEmailInvalid;
                      final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                      if (!regex.hasMatch(v.trim())) return l10n.registerErrorEmailInvalid;
                      if (errorCode == 'email_exists') return l10n.registerErrorEmailExists;
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: l10n.registerEmailLabel,
                      hintText: l10n.registerEmailHint,
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                  ),
                  AppSpacing.verticalMD,
                  TextFormField(
                    onChanged: onPasswordChanged,
                    obscureText: true,
                    validator: (v) {
                      if (v == null || v.length < 6) return l10n.registerErrorPasswordShort;
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: l10n.registerPasswordLabel,
                      hintText: l10n.registerPasswordHint,
                      prefixIcon: const Icon(Icons.lock_outline),
                    ),
                  ),
                  AppSpacing.verticalMD,
                  TextFormField(
                    onChanged: onConfirmChanged,
                    obscureText: true,
                    validator: (v) {
                      if ((v ?? '').isEmpty) return l10n.registerErrorPasswordMismatch;
                      if (v != password) return l10n.registerErrorPasswordMismatch;
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: l10n.registerConfirmPasswordLabel,
                      hintText: l10n.registerPasswordHint,
                      prefixIcon: const Icon(Icons.lock_outline),
                    ),
                  ),
                  AppSpacing.verticalXL,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isSubmitting ? null : onSubmit,
                      child: isSubmitting
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : Text(l10n.registerButton),
                    ),
                  ),
                  AppSpacing.verticalMD,
                  TextButton(
                    onPressed: onLoginTap,
                    child: Text(l10n.registerCta),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
