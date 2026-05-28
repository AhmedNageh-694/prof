import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/module.dart';
import '../theme/app_theme.dart';

class ModuleCard extends StatefulWidget {
  final Module module;
  final VoidCallback onTap;

  const ModuleCard({super.key, required this.module, required this.onTap});

  @override
  State<ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<ModuleCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isHovered = true),
      onTapUp: (_) => setState(() => _isHovered = false),
      onTapCancel: () => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transformAlignment: Alignment.center,
        transform: Matrix4.identity()..scaleByDouble(_isHovered ? 0.96 : 1.0, 0.96, 1.0, 1.0),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered ? widget.module.accentColor.withValues(alpha: 0.5) : AppColors.border.withValues(alpha: 0.6), 
            width: 1.5,
          ),
          boxShadow: [
            if (!_isHovered)
              BoxShadow(
                color: widget.module.accentColor.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            if (_isHovered)
              BoxShadow(
                color: widget.module.accentColor.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
          ],
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: widget.module.accentColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(widget.module.icon, color: widget.module.accentColor, size: 28),
            ),
            const SizedBox(height: 16),
            Text(
              widget.module.title,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.foreground,
                height: 1.25,
                letterSpacing: -0.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                widget.module.category,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mutedForeground,
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Icon(Icons.play_circle_fill, size: 18, color: widget.module.accentColor),
                const SizedBox(width: 6),
                Text(
                  '${widget.module.lessonsCount} lessons',
                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.mutedForeground),
                ),
                const Spacer(),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: widget.module.accentColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_forward_ios, size: 12, color: widget.module.accentColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
