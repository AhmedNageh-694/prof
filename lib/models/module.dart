import 'package:flutter/material.dart';

class Module {
  final String id;
  final String title;
  final String category;
  final IconData icon;
  final Color accentColor;
  final int lessonsCount;
  final String duration;

  const Module({
    required this.id,
    required this.title,
    required this.category,
    required this.icon,
    required this.accentColor,
    required this.lessonsCount,
    required this.duration,
  });
}
