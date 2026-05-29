import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../localization/app_localizations.dart';
import '../localization/locale_cubit.dart';
import '../core/constants/app_colors.dart';

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  int _locationToIndex(String location) {
    if (location.startsWith('/notifications')) return 1;
    if (location.startsWith('/player')) return 2;
    return 0; // /home
  }

  void _onNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
      case 1:
        context.go('/notifications');
      case 2:
        context.go('/player');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.card,
          border: Border(top: BorderSide(color: AppColors.border, width: 1)),
        ),
        child: SafeArea(
          top: false,
          child: NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: (i) => _onNavTap(context, i),
            backgroundColor: AppColors.card,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home_rounded),
                label: l10n.myModules,
              ),
              NavigationDestination(
                icon: const Icon(Icons.notifications_outlined),
                selectedIcon: const Icon(Icons.notifications_rounded),
                label: l10n.notifications,
              ),
              NavigationDestination(
                icon: const Icon(Icons.play_circle_outline_rounded),
                selectedIcon: const Icon(Icons.play_circle_rounded),
                label: l10n.nowPlaying,
              ),
            ],
          ),
        ),
      ),
      // Language toggle FAB — available on all inner screens
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          final current =
              context.read<LocaleCubit>().state.languageCode;
          context.read<LocaleCubit>().changeLanguage(
                current == 'en' ? 'ar' : 'en',
              );
        },
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        tooltip: l10n.changeLanguage,
        child: const Icon(Icons.language, size: 20),
      ),
    );
  }
}
