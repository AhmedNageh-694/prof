import 'package:flutter/material.dart';

class RelatedContent {
  final String id;
  final String title;
  final String duration;
  final IconData icon;
  final Color accentColor;

  const RelatedContent({
    required this.id,
    required this.title,
    required this.duration,
    required this.icon,
    required this.accentColor,
  });
}
