import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection.dart';
import '../../../../shared/utils/responsive.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../../../localization/app_localizations.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Responsive(
              mobile: const _SignUpForm(),
              tablet: const SizedBox(width: 400, child: _SignUpForm()),
              desktop: const SizedBox(width: 450, child: _SignUpForm()),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignUpForm extends StatefulWidget {
  const _SignUpForm();

  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSignUp() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
            SignUpSubmitted(_emailController.text, _passwordController.text),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.successSignup)),
          );
          context.go('/home');
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.createAnAccount,
                style: theme.textTheme.displayLarge?.copyWith(fontSize: 28),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              CustomTextField(
                label: l10n.email,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.isEmpty) return l10n.emptyFieldError;
                  if (!RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(val)) {
                    return l10n.invalidEmailError;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: l10n.password,
                isPassword: true,
                controller: _passwordController,
                validator: (val) {
                  if (val == null || val.isEmpty) return l10n.emptyFieldError;
                  if (val.length < 6) return l10n.weakPasswordError;
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: l10n.confirmPassword,
                isPassword: true,
                controller: _confirmPasswordController,
                validator: (val) {
                  if (val == null || val.isEmpty) return l10n.emptyFieldError;
                  if (val != _passwordController.text) {
                    return l10n.passwordMismatchError;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: l10n.signup,
                isLoading: state is AuthLoading,
                onPressed: _onSignUp,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.go('/login'),
                child: Text(l10n.alreadyHaveAccount),
              ),
            ],
          ),
        );
      },
    );
  }
}
