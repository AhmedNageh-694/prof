import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/related_content.dart';
import '../theme/app_theme.dart';
import '../widgets/related_card.dart';

const _related = [
  RelatedContent(
    id: 'r1',
    title: 'Color Theory Basics',
    duration: '12 min',
    icon: Icons.water_drop_outlined,
    accentColor: AppColors.accentPink,
  ),
  RelatedContent(
    id: 'r2',
    title: 'Typography in Design',
    duration: '18 min',
    icon: Icons.text_fields,
    accentColor: AppColors.accentPurple,
  ),
  RelatedContent(
    id: 'r3',
    title: 'Grid Systems',
    duration: '22 min',
    icon: Icons.grid_on_outlined,
    accentColor: AppColors.accentBlue,
  ),
  RelatedContent(
    id: 'r4',
    title: 'Icon Design',
    duration: '15 min',
    icon: Icons.star_outline,
    accentColor: AppColors.accentAmber,
  ),
  RelatedContent(
    id: 'r5',
    title: 'Motion Principles',
    duration: '25 min',
    icon: Icons.bolt_outlined,
    accentColor: AppColors.accentGreen,
  ),
];

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  double _progress = 0.28;
  bool _liked = false;
  bool _bookmarked = false;
  bool _muted = false;
  Timer? _timer;

  late AnimationController _playBtnController;
  late Animation<double> _playBtnScale;

  @override
  void initState() {
    super.initState();
    _playBtnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _playBtnScale = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _playBtnController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _playBtnController.dispose();
    super.dispose();
  }

  void _togglePlay() {
    _playBtnController.forward().then((_) => _playBtnController.reverse());
    setState(() => _isPlaying = !_isPlaying);

    if (!_isPlaying) {
      _timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
        if (!mounted) return;
        setState(() {
          _progress = (_progress + 0.002).clamp(0.0, 1.0);
          if (_progress >= 1.0) {
            _isPlaying = false;
            _timer?.cancel();
          }
        });
      });
    } else {
      _timer?.cancel();
    }
  }

  String _formatTime(double frac) {
    final total = (frac * 45 * 60).round();
    final m = (total ~/ 60).toString().padLeft(2, '0');
    final s = (total % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: topPad + 12,
              child: Container(color: AppColors.background),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _iconBtn(Icons.chevron_left, () {}),
                  const Spacer(),
                  Text(
                    'Now Playing',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.foreground,
                    ),
                  ),
                  const Spacer(),
                  _iconBtn(
                    Icons.bookmark_outline,
                    () => setState(() => _bookmarked = !_bookmarked),
                    color: _bookmarked ? AppColors.primary : AppColors.foreground,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.07),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    _buildVideoArea(),
                    _buildControls(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildDescCard(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 8),
              child: Text(
                'Up Next',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.foreground,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            SizedBox(
              height: 172,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _related.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (_, i) =>
                    RelatedCard(item: _related[i], onTap: () {}),
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoArea() {
    return Container(
      height: 220,
      width: double.infinity,
      color: AppColors.primary.withValues(alpha: 0.1),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Icon(Icons.draw_outlined,
                color: AppColors.primary, size: 48),
          ),
          Positioned(
            top: 14,
            right: 14,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.accentRed.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.accentRed,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'HD',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accentRed,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!_isPlaying)
            GestureDetector(
              onTap: _togglePlay,
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.play_arrow,
                    color: Colors.white, size: 32),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.muted,
              thumbColor: AppColors.primary,
              overlayColor: AppColors.primary.withValues(alpha: 0.12),
              trackHeight: 4,
              thumbShape:
                  const RoundSliderThumbShape(enabledThumbRadius: 7),
            ),
            child: Slider(
              value: _progress,
              onChanged: (v) => setState(() => _progress = v),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatTime(_progress),
                    style: GoogleFonts.inter(
                        fontSize: 12, color: AppColors.mutedForeground)),
                Text('45:00',
                    style: GoogleFonts.inter(
                        fontSize: 12, color: AppColors.mutedForeground)),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _controlBtn(Icons.skip_previous_outlined, () {}),
              const SizedBox(width: 20),
              ScaleTransition(
                scale: _playBtnScale,
                child: GestureDetector(
                  onTap: _togglePlay,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              _controlBtn(Icons.skip_next_outlined, () {}),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _smallActionBtn(
                _muted ? Icons.volume_off_outlined : Icons.volume_up_outlined,
                () => setState(() => _muted = !_muted),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  '1x',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              _smallActionBtn(
                Icons.favorite_outline,
                () => setState(() => _liked = !_liked),
                active: _liked,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Design Fundamentals — Lesson 7',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.foreground,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Design Fundamentals · 24 lessons',
            style: GoogleFonts.inter(
                fontSize: 13, color: AppColors.mutedForeground),
          ),
          const SizedBox(height: 12),
          Divider(color: AppColors.border),
          const SizedBox(height: 8),
          Text(
            "In this lesson, you'll explore the core visual principles that underpin great design — balance, contrast, alignment, and proximity. Discover how professional designers structure layouts and create hierarchy that guides the eye naturally through any composition.",
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.mutedForeground,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _stat(Icons.people_outline, '2.4k students', AppColors.primary),
              _vertDivider(),
              _stat(Icons.star_outline, '4.9 rating', AppColors.accentAmber),
              _vertDivider(),
              _stat(Icons.access_time, '45 min', AppColors.primary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(IconData icon, String label, Color color) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Text(label,
              style: GoogleFonts.inter(
                  fontSize: 12, color: AppColors.mutedForeground)),
        ],
      ),
    );
  }

  Widget _vertDivider() {
    return Container(width: 1, height: 20, color: AppColors.border);
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap, {Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, size: 22, color: color ?? AppColors.foreground),
      ),
    );
  }

  Widget _controlBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.muted,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, size: 22, color: AppColors.foreground),
      ),
    );
  }

  Widget _smallActionBtn(IconData icon, VoidCallback onTap,
      {bool active = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: active
              ? AppColors.primary.withValues(alpha: 0.12)
              : AppColors.muted,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon,
            size: 18,
            color: active ? AppColors.primary : AppColors.foreground),
      ),
    );
  }
}
