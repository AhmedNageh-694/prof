import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/module.dart';
import '../core/constants/app_colors.dart';
import '../widgets/module_card.dart';
import '../widgets/search_bar_widget.dart';
import '../localization/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  String _activeCategory = '';
  bool _filterActive = false;
  String _searchText = '';
  late AnimationController _animationController;

  List<Module> _modules(AppLocalizations l10n) => [
    Module(
      id: '1',
      title: 'Design Fundamentals',
      category: l10n.filterCreative,
      icon: Icons.draw_outlined,
      accentColor: AppColors.accentTeal,
      lessonsCount: 24,
      duration: '6h 30m',
    ),
    Module(
      id: '2',
      title: 'Web Development',
      category: l10n.filterEngineering,
      icon: Icons.code,
      accentColor: AppColors.accentBlue,
      lessonsCount: 32,
      duration: '9h 15m',
    ),
    Module(
      id: '3',
      title: 'Mobile Apps',
      category: l10n.filterEngineering,
      icon: Icons.smartphone_outlined,
      accentColor: AppColors.accentPurple,
      lessonsCount: 28,
      duration: '7h 45m',
    ),
    Module(
      id: '4',
      title: 'Data Science',
      category: l10n.filterAnalytics,
      icon: Icons.bar_chart_outlined,
      accentColor: AppColors.accentGreen,
      lessonsCount: 36,
      duration: '11h',
    ),
    Module(
      id: '5',
      title: 'Growth Marketing',
      category: l10n.filterBusiness,
      icon: Icons.trending_up,
      accentColor: AppColors.accentAmber,
      lessonsCount: 18,
      duration: '4h 20m',
    ),
    Module(
      id: '6',
      title: 'Photography',
      category: l10n.filterCreative,
      icon: Icons.camera_alt_outlined,
      accentColor: AppColors.accentPink,
      lessonsCount: 20,
      duration: '5h 10m',
    ),
    Module(
      id: '7',
      title: 'Business Strategy',
      category: l10n.filterBusiness,
      icon: Icons.business_center_outlined,
      accentColor: AppColors.accentOrange,
      lessonsCount: 16,
      duration: '3h 50m',
    ),
    Module(
      id: '8',
      title: 'UX Research',
      category: l10n.filterCreative,
      icon: Icons.people_outline,
      accentColor: AppColors.accentRed,
      lessonsCount: 22,
      duration: '5h 30m',
    ),
  ];

  List<String> _categories(AppLocalizations l10n) => [
    l10n.filterAll,
    l10n.filterCreative,
    l10n.filterEngineering,
    l10n.filterBusiness,
    l10n.filterAnalytics,
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _searchController.addListener(() {
      setState(() => _searchText = _searchController.text);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Module> _filtered(AppLocalizations l10n) {
    final allCat = l10n.filterAll;
    return _modules(l10n).where((m) {
      final matchSearch =
          _searchText.isEmpty ||
          m.title.toLowerCase().contains(_searchText.toLowerCase()) ||
          m.category.toLowerCase().contains(_searchText.toLowerCase());
      final matchCategory =
          _activeCategory.isEmpty ||
          _activeCategory == allCat ||
          m.category == _activeCategory;
      return matchSearch && matchCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filtered = _filtered(l10n);
    final categories = _categories(l10n);

    // Initialize activeCategory with l10n value on first build
    if (_activeCategory.isEmpty) {
      _activeCategory = l10n.filterAll;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                left: 20,
                right: 20,
                bottom: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0D9488), Color(0xFF3B82F6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0D9488).withValues(alpha: 0.35),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.goodMorning,
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withValues(alpha: 0.85),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                l10n.readyToLearn,
                                style: GoogleFonts.inter(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.2),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.6),
                              width: 1.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.person_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Search bar
                  SearchBarWidget(
                    controller: _searchController,
                    placeholder: l10n.searchModules,
                    onFilterTap: () {
                      setState(() {
                        _filterActive = !_filterActive;
                        if (!_filterActive) {
                          _activeCategory = l10n.filterAll;
                        }
                      });
                    },
                    filterActive: _filterActive,
                  ),

                  // Filter categories
                  AnimatedCrossFade(
                    firstChild: const SizedBox(
                      width: double.infinity,
                      height: 0,
                    ),
                    secondChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: categories.map((cat) {
                              final selected = _activeCategory == cat;
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() => _activeCategory = cat),
                                  child: AnimatedContainer(
                                    duration: const Duration(
                                      milliseconds: 300,
                                    ),
                                    curve: Curves.easeOutCubic,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 22,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: selected
                                          ? AppColors.primary
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: selected
                                          ? [
                                              BoxShadow(
                                                color: AppColors.primary
                                                    .withValues(alpha: 0.35),
                                                blurRadius: 10,
                                                offset: const Offset(0, 4),
                                              ),
                                            ]
                                          : [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withValues(alpha: 0.04),
                                                blurRadius: 6,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                      border: Border.all(
                                        color: selected
                                            ? AppColors.primary
                                            : AppColors.border.withValues(
                                                alpha: 0.6,
                                              ),
                                      ),
                                    ),
                                    child: Text(
                                      cat,
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: selected
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: selected
                                            ? Colors.white
                                            : AppColors.mutedForeground,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    crossFadeState: _filterActive
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                    sizeCurve: Curves.easeOutCubic,
                  ),

                  const SizedBox(height: 32),
                  Text(
                    l10n.myModules,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.foreground,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),

          if (filtered.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutBack,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Opacity(
                        opacity: value.clamp(0.0, 1.0),
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.search_off_rounded,
                          size: 56,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        l10n.noModulesFound,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.foreground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.adjustSearchOrFilters,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: AppColors.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.78,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, child) {
                        final delay = index * 0.1;
                        final adjustedValue =
                            (value * 1.5 - delay).clamp(0.0, 1.0);
                        return Transform.translate(
                          offset: Offset(0, 40 * (1 - adjustedValue)),
                          child: Opacity(
                            opacity: adjustedValue,
                            child: child,
                          ),
                        );
                      },
                      child: ModuleCard(
                        module: filtered[index],
                        onTap: () {},
                      ),
                    );
                  },
                  childCount: filtered.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
