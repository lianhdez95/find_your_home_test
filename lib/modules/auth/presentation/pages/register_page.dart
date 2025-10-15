import 'package:find_your_home_test/core/theme/theme_extensions.dart';
import 'package:find_your_home_test/modules/auth/presentation/bloc/register/register_bloc.dart';
import 'package:find_your_home_test/modules/auth/presentation/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:find_your_home_test/l10n/generated/app_localizations.dart';
import 'package:find_your_home_test/shared/widgets/app_dialog.dart';
import 'package:find_your_home_test/di/di.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;

  _onLoginTap() {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<RegisterBloc>(),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.status == RegisterStatus.success) {
            final l10n = AppLocalizations.of(context)!;
            AppDialog.show(
              context,
              title: l10n.registerSuccess,
              iconData: Icons.check_circle,
              confirmText: l10n.loginButton,
              color: context.successColor,
              onConfirm: () => context.go('/login'),
            );
          }
          if (state.status == RegisterStatus.failure && state.errorCode == 'email_exists') {
            if (_submitted) _formKey.currentState?.validate();
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: RegisterView(
              formKey: _formKey,
              autovalidateMode: _submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
              onLoginTap: _onLoginTap,
              onSubmit: () {
                setState(() => _submitted = true);
                final valid = _formKey.currentState?.validate() ?? false;
                if (!valid) return;
                context.read<RegisterBloc>().add(const RegisterSubmitted());
              },
              isSubmitting: state.status == RegisterStatus.submitting,
              errorCode: state.errorCode,
              password: state.password,
              onNameChanged: (v) => context.read<RegisterBloc>().add(RegisterNameChanged(v)),
              onEmailChanged: (v) => context.read<RegisterBloc>().add(RegisterEmailChanged(v)),
              onPasswordChanged: (v) => context.read<RegisterBloc>().add(RegisterPasswordChanged(v)),
              onConfirmChanged: (v) => context.read<RegisterBloc>().add(RegisterConfirmPasswordChanged(v)),
            ),
          );
        },
      ),
    );
  }
}