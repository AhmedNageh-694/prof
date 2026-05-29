import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_colors.dart';

class SearchBarWidget extends StatefulWidget {
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
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(SearchBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onTextChanged);
      widget.controller.addListener(_onTextChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() => setState(() {});

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
              controller: widget.controller,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: AppColors.foreground,
              ),
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: GoogleFonts.inter(
                  fontSize: 15,
                  color: AppColors.mutedForeground,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.mutedForeground,
                  size: 20,
                ),
                suffixIcon: widget.controller.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () => widget.controller.clear(),
                        child: const Icon(
                          Icons.close,
                          color: AppColors.mutedForeground,
                          size: 18,
                        ),
                      )
                    : null,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
        ),
        if (widget.onFilterTap != null) ...[
          const SizedBox(width: 10),
          GestureDetector(
            onTap: widget.onFilterTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color:
                    widget.filterActive ? AppColors.primary : AppColors.card,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: widget.filterActive
                      ? AppColors.primary
                      : AppColors.border,
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
                color: widget.filterActive
                    ? Colors.white
                    : AppColors.foreground,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
