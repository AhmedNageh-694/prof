import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final VoidCallback? onFilterTap;
  final bool filterActive;

  const SearchBarWidget({
    super.key,
    required this.controller,
    this.placeholder = 'Search...',
    this.onFilterTap,
    this.filterActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              style: GoogleFonts.inter(fontSize: 15, color: AppColors.foreground),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: GoogleFonts.inter(
                    fontSize: 15, color: AppColors.mutedForeground),
                prefixIcon: const Icon(Icons.search,
                    color: AppColors.mutedForeground, size: 20),
                suffixIcon: controller.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () => controller.clear(),
                        child: const Icon(Icons.close,
                            color: AppColors.mutedForeground, size: 18),
                      )
                    : null,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
        ),
        if (onFilterTap != null) ...[
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: filterActive ? AppColors.primary : AppColors.card,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: filterActive ? AppColors.primary : AppColors.border,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Icon(
                Icons.tune,
                size: 20,
                color: filterActive ? Colors.white : AppColors.foreground,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
