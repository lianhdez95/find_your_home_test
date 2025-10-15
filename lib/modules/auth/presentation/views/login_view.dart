import 'package:find_your_home_test/core/theme/theme_extensions.dart';
import 'package:find_your_home_test/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;
  final VoidCallback? onSubmit;
  final VoidCallback? onRegisterTap;
  final VoidCallback? onLogoTap;
  final ValueChanged<String>? onEmailChanged;
  final ValueChanged<String>? onPasswordChanged;
  final bool isSubmitting;
  final String? errorCode;

  const LoginView({
    super.key,
    required this.formKey,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onSubmit,
    this.onRegisterTap,
    this.onLogoTap,
    this.onEmailChanged,
    this.onPasswordChanged,
    this.isSubmitting = false,
    this.errorCode,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
  final double height = MediaQuery.of(context).size.height;

    return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: onLogoTap,
              child: SizedBox(
                height: height * 0.35,
                child: Image.asset('assets/images/app_logo.png')),
            ),

            Text(
              l10n!.loginWelcome,
              style: context.displayMedium.copyWith(color: context.primaryBlue),
              textAlign: TextAlign.center,
            ),
            AppSpacing.verticalSM,
            Text(
              l10n.loginSubtitle,
              style: context.bodyLarge.copyWith(
                color: context.colorScheme.onSurface.withAlpha(170),
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.verticalXL,

            // Formulario de login
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: formKey,
                autovalidateMode: autovalidateMode,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: onEmailChanged,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: l10n.loginEmailLabel,
                        hintText: l10n.loginEmailHint,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      validator: (v) {
                        final value = v?.trim() ?? '';
                        if (value.isEmpty) return l10n.registerErrorEmailInvalid;
                        final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                            if (!regex.hasMatch(value)) return l10n.registerErrorEmailInvalid;
                        return null;
                      },
                    ),
                    AppSpacing.verticalMD,
                    TextFormField(
                      obscureText: true,
                      onChanged: onPasswordChanged,
                      decoration: InputDecoration(
                        labelText: l10n.loginPasswordLabel,
                        hintText: l10n.loginPasswordHint,
                        prefixIcon: const Icon(Icons.lock_outline),
                      ),
                      validator: (v) {
                        final value = v ?? '';
                        if (value.isEmpty) return l10n.loginErrorPasswordEmpty;
                        if (errorCode == 'invalid_credentials') return l10n.loginErrorInvalidCredentials;
                        return null;
                      },
                    ),
                    AppSpacing.verticalXL,
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isSubmitting ? null : onSubmit,
                        child: isSubmitting
                            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                            : Text(l10n.loginButton),
                      ),
                    ),
                    AppSpacing.verticalMD,
                    TextButton(
                      onPressed: onRegisterTap,
                      child: Text(l10n.loginRegisterCta),
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
