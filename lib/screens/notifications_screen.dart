import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/notification_item.dart';
import '../core/constants/app_colors.dart';
import '../widgets/notification_card.dart';
import '../localization/app_localizations.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<NotificationModel> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = [
      NotificationModel(
        id: 'n1',
        title: 'New Course Available',
        preview:
            'Advanced UX Research has just been published. Start learning now.',
        timestamp: '2m ago',
        icon: Icons.menu_book_outlined,
        iconColor: AppColors.accentTeal,
        isRead: false,
      ),
      NotificationModel(
        id: 'n2',
        title: 'Assignment Due Soon',
        preview: 'Your Design Fundamentals assignment is due in 2 hours.',
        timestamp: '1h ago',
        icon: Icons.warning_amber_outlined,
        iconColor: AppColors.accentAmber,
        isRead: false,
      ),
      NotificationModel(
        id: 'n3',
        title: 'Achievement Unlocked',
        preview:
            "You've completed 10 lessons in a row. Keep up the great work!",
        timestamp: '3h ago',
        icon: Icons.emoji_events_outlined,
        iconColor: AppColors.accentPurple,
        isRead: false,
      ),
      NotificationModel(
        id: 'n4',
        title: 'New Comment',
        preview:
            'Sarah commented on your project: "Love the color palette you chose!"',
        timestamp: '5h ago',
        icon: Icons.chat_bubble_outline,
        iconColor: AppColors.accentBlue,
        isRead: true,
      ),
      NotificationModel(
        id: 'n5',
        title: 'Weekly Digest',
        preview:
            "You've made progress on 4 modules this week. View your weekly summary.",
        timestamp: '1d ago',
        icon: Icons.bar_chart_outlined,
        iconColor: AppColors.accentGreen,
        isRead: true,
      ),
      NotificationModel(
        id: 'n6',
        title: 'Instructor Feedback',
        preview: 'Your submission for Grid Systems received instructor feedback.',
        timestamp: '2d ago',
        icon: Icons.edit_outlined,
        iconColor: AppColors.accentPink,
        isRead: true,
      ),
      NotificationModel(
        id: 'n7',
        title: 'Module Certificate',
        preview:
            'Congratulations! Your Web Development certificate is ready to download.',
        timestamp: '3d ago',
        icon: Icons.workspace_premium_outlined,
        iconColor: AppColors.accentOrange,
        isRead: true,
      ),
    ];
  }

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  void _markAllRead() {
    setState(() {
      for (final n in _notifications) {
        n.isRead = true;
      }
    });
  }

  void _markRead(String id) {
    setState(() {
      final n = _notifications.firstWhere((n) => n.id == id);
      n.isRead = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final topPad = MediaQuery.of(context).padding.top;
    final unread = _notifications.where((n) => !n.isRead).toList();
    final read = _notifications.where((n) => n.isRead).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.background,
              padding: EdgeInsets.only(
                top: topPad + 16,
                left: 20,
                right: 20,
                bottom: 16,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        l10n.notifications,
                        style: GoogleFonts.inter(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: AppColors.foreground,
                          letterSpacing: -0.5,
                        ),
                      ),
                      if (_unreadCount > 0) ...[
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$_unreadCount',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                      const Spacer(),
                      if (_unreadCount > 0)
                        GestureDetector(
                          onTap: _markAllRead,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle_outline,
                                  size: 14,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  l10n.markAllRead,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 1),
                  const Divider(color: AppColors.border),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                if (unread.isNotEmpty) ...[
                  _sectionLabel(l10n.sectionNew),
                  const SizedBox(height: 10),
                  ...unread.map(
                    (n) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: NotificationCard(
                        notification: n,
                        onTap: () => _markRead(n.id),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                if (read.isNotEmpty) ...[
                  _sectionLabel(l10n.sectionEarlier),
                  const SizedBox(height: 10),
                  ...read.map(
                    (n) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: NotificationCard(
                        notification: n,
                        onTap: () => _markRead(n.id),
                      ),
                    ),
                  ),
                ],
                if (_notifications.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 80),
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: AppColors.muted,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Icon(
                              Icons.notifications_off_outlined,
                              size: 32,
                              color: AppColors.mutedForeground,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            l10n.allCaughtUp,
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.foreground,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.noNewNotifications,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppColors.mutedForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.mutedForeground,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
