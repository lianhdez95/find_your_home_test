import 'package:find_your_home_test/core/theme/theme_extensions.dart';
import 'package:find_your_home_test/modules/auth/presentation/views/login_view.dart';
import 'package:find_your_home_test/shared/widgets/app_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:find_your_home_test/di/di.dart';
import 'package:find_your_home_test/modules/auth/presentation/bloc/login/login_bloc.dart';
import 'package:find_your_home_test/l10n/generated/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;

  

  @override
  void initState() {
    super.initState();
  }

  _onRegisterTap() {
    context.push('/register');
  }

  _onLogoTap() {
    // Acción al presionar el logo
    // Por ejemplo, navegar a la pantalla de inicio
    context.push('/theme');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<LoginBloc>(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
            final l10n = AppLocalizations.of(context)!;
            if (state.status == LoginStatus.success) {
              // Navegar al home pasando datos del usuario autenticado
              context.go('/home', extra: {
                'email': state.userEmail,
                'name': state.userName,
              });
            }
            if (state.status == LoginStatus.failure) {
              // user_not_found: se maneja con diálogo
              if (state.errorCode == 'user_not_found') {
                AppDialog.show(
                  context,
                  title: l10n.loginErrorUserNotFound,
                  iconData: Icons.error_outline,
                  confirmText: l10n.accept,
                  color: context.errorColor,
                  onConfirm: () {},
                );
                return;
              }
              // Otros errores se reflejan en el formulario (invalid_credentials, etc.)
              if (!_submitted) setState(() => _submitted = true);
              _formKey.currentState?.validate();
            }
        },
        builder: (context, state) {
          return Scaffold(
            body: LoginView(
              formKey: _formKey,
              autovalidateMode: _submitted ? AutovalidateMode.always : AutovalidateMode.disabled,
              onSubmit: () {
                setState(() => _submitted = true);
                final valid = _formKey.currentState?.validate() ?? false;
                if (!valid) return;
                context.read<LoginBloc>().add(const LoginSubmitted());
              },
              onRegisterTap: _onRegisterTap,
              onLogoTap: _onLogoTap,
              onEmailChanged: (v) => context.read<LoginBloc>().add(LoginEmailChanged(v)),
              onPasswordChanged: (v) => context.read<LoginBloc>().add(LoginPasswordChanged(v)),
              isSubmitting: state.status == LoginStatus.submitting,
              errorCode: state.errorCode,
            ),
          );
        },
      ),
    );
  }
}