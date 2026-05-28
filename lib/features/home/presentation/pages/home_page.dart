import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../localization/locale_cubit.dart';
import '../../../../localization/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: l10n.changeLanguage,
            onPressed: () {
              final currentLocale = context.read<LocaleCubit>().state.languageCode;
              final newLocale = currentLocale == 'en' ? 'ar' : 'en';
              context.read<LocaleCubit>().changeLanguage(newLocale);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Usually we would dispatch an AuthLogout event to AuthBloc
              // but for now we just redirect to login
              context.go('/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'Welcome to ${l10n.appTitle}!',
            style: theme.textTheme.displayLarge?.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
