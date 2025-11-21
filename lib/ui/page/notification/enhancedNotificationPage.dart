import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pix/l10n/app_localizations.dart';
import 'package:pix/ui/theme/theme.dart';
import 'package:pix/widgets/customAppBar.dart';
import 'package:pix/widgets/optimizedListView.dart';
import 'package:pix/widgets/verificationBadge.dart';

class EnhancedNotificationPage extends StatefulWidget {
  const EnhancedNotificationPage({Key? key}) : super(key: key);

  static Route<T> getRoute<T>() {
    return MaterialPageRoute(
      builder: (_) => const EnhancedNotificationPage(),
    );
  }

  @override
  State<EnhancedNotificationPage> createState() => _EnhancedNotificationPageState();
}

class _EnhancedNotificationPageState extends State<EnhancedNotificationPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  
  final List<NotificationItem> _allNotifications = [
    NotificationItem(
      id: '1',
      type: NotificationType.like,
      userName: 'أحمد محمد',
      userAvatar: 'https://example.com/avatar1.jpg',
      isVerified: true,
      content: 'أعجب بتغريدتك',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
    ),
    NotificationItem(
      id: '2',
      type: NotificationType.follow,
      userName: 'سارة أحمد',
      userAvatar: 'https://example.com/avatar2.jpg',
      isVerified: false,
      content: 'بدأت في متابعتك',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      isRead: false,
    ),
    NotificationItem(
      id: '3',
      type: NotificationType.comment,
      userName: 'محمد علي',
      userAvatar: 'https://example.com/avatar3.jpg',
      isVerified: true,
      content: 'علق على تغريدتك: "رائع جداً!"',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: true,
    ),
    NotificationItem(
      id: '4',
      type: NotificationType.retweet,
      userName: 'فاطمة حسن',
      userAvatar: 'https://example.com/avatar4.jpg',
      isVerified: false,
      content: 'أعاد تغريد منشورك',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
    NotificationItem(
      id: '5',
      type: NotificationType.mention,
      userName: 'عبدالله سالم',
      userAvatar: 'https://example.com/avatar5.jpg',
      isVerified: true,
      content: 'ذكرك في تغريدة',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<NotificationItem> get _unreadNotifications =>
      _allNotifications.where((n) => !n.isRead).toList();

  List<NotificationItem> get _mentionNotifications =>
      _allNotifications.where((n) => n.type == NotificationType.mention).toList();

  List<NotificationItem> get _followNotifications =>
      _allNotifications.where((n) => n.type == NotificationType.follow).toList();

  void _markAsRead(String notificationId) {
    setState(() {
      final notification = _allNotifications.firstWhere((n) => n.id == notificationId);
      notification.isRead = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _allNotifications) {
        notification.isRead = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        isBackButton: true,
        title: localizations.notifications,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'mark_all_read':
                  _markAllAsRead();
                  break;
                case 'settings':
                  // Navigate to notification settings
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'mark_all_read',
                child: Row(
                  children: [
                    const Icon(Icons.done_all),
                    const SizedBox(width: 8),
                    Text(localizations.markAllAsRead),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    const Icon(Icons.settings),
                    const SizedBox(width: 8),
                    Text(localizations.settings),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: Theme.of(context).cardColor,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(localizations.all),
                      if (_allNotifications.any((n) => !n.isRead)) ...[
                        const SizedBox(width: 4),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(localizations.unread),
                      if (_unreadNotifications.isNotEmpty) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${_unreadNotifications.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Tab(text: localizations.mentions),
                Tab(text: localizations.followers),
              ],
            ),
          ),
          
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildNotificationList(_allNotifications),
                _buildNotificationList(_unreadNotifications),
                _buildNotificationList(_mentionNotifications),
                _buildNotificationList(_followNotifications),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(List<NotificationItem> notifications) {
    final localizations = AppLocalizations.of(context)!;
    
    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              localizations.noNotifications,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return OptimizedListViewBuilder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationTile(notification);
      },
      separator: const Divider(height: 0),
    );
  }

  Widget _buildNotificationTile(NotificationItem notification) {
    return Container(
      color: notification.isRead 
          ? Theme.of(context).cardColor 
          : Theme.of(context).primaryColor.withOpacity(0.05),
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(notification.userAvatar),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getNotificationIcon(notification.type),
                  size: 12,
                  color: _getNotificationColor(notification.type),
                ),
              ),
            ),
          ],
        ),
        title: Row(
          children: [
            Expanded(
              child: UserVerificationStatus(
                isVerified: notification.isVerified,
                userName: notification.userName,
                badgeSize: 14,
                nameStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
              ),
            ),
            Text(
              _formatTimestamp(notification.timestamp),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            notification.content,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ),
        onTap: () {
          if (!notification.isRead) {
            _markAsRead(notification.id);
          }
          // Navigate to relevant content
        },
        trailing: !notification.isRead
            ? Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: TwitterColor.dodgerBlue,
                  shape: BoxShape.circle,
                ),
              )
            : null,
      ),
    );
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.like:
        return Icons.favorite;
      case NotificationType.comment:
        return Icons.chat_bubble;
      case NotificationType.retweet:
        return Icons.repeat;
      case NotificationType.follow:
        return Icons.person_add;
      case NotificationType.mention:
        return Icons.alternate_email;
    }
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.like:
        return Colors.red;
      case NotificationType.comment:
        return TwitterColor.dodgerBlue;
      case NotificationType.retweet:
        return Colors.green;
      case NotificationType.follow:
        return Colors.purple;
      case NotificationType.mention:
        return Colors.orange;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'الآن';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}د';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}س';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}ي';
    } else {
      return '${timestamp.day}/${timestamp.month}';
    }
  }
}

enum NotificationType {
  like,
  comment,
  retweet,
  follow,
  mention,
}

class NotificationItem {
  final String id;
  final NotificationType type;
  final String userName;
  final String userAvatar;
  final bool isVerified;
  final String content;
  final DateTime timestamp;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.type,
    required this.userName,
    required this.userAvatar,
    required this.isVerified,
    required this.content,
    required this.timestamp,
    required this.isRead,
  });
}