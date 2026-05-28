import 'package:flutter/material.dart';

class NotificationModel {
  final String id;
  final String title;
  final String preview;
  final String timestamp;
  final IconData icon;
  final Color iconColor;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.preview,
    required this.timestamp,
    required this.icon,
    required this.iconColor,
    required this.isRead,
  });
}
