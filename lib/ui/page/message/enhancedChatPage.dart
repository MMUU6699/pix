import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pix/l10n/app_localizations.dart';
import 'package:pix/ui/theme/theme.dart';
import 'package:pix/widgets/customAppBar.dart';
import 'package:pix/widgets/optimizedListView.dart';
import 'package:pix/widgets/verificationBadge.dart';

class EnhancedChatPage extends StatefulWidget {
  final String chatId;
  final String recipientName;
  final String recipientAvatar;
  final bool isRecipientVerified;

  const EnhancedChatPage({
    Key? key,
    required this.chatId,
    required this.recipientName,
    required this.recipientAvatar,
    this.isRecipientVerified = false,
  }) : super(key: key);

  static Route<T> getRoute<T>({
    required String chatId,
    required String recipientName,
    required String recipientAvatar,
    bool isRecipientVerified = false,
  }) {
    return MaterialPageRoute(
      builder: (_) => EnhancedChatPage(
        chatId: chatId,
        recipientName: recipientName,
        recipientAvatar: recipientAvatar,
        isRecipientVerified: isRecipientVerified,
      ),
    );
  }

  @override
  State<EnhancedChatPage> createState() => _EnhancedChatPageState();
}

class _EnhancedChatPageState extends State<EnhancedChatPage>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _messageFocusNode = FocusNode();
  
  bool _isTyping = false;
  bool _isRecipientOnline = true;
  DateTime? _lastSeen;
  
  final List<ChatMessage> _messages = [
    ChatMessage(
      id: '1',
      senderId: 'other',
      content: 'مرحباً! كيف حالك؟',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      type: MessageType.text,
      isRead: true,
    ),
    ChatMessage(
      id: '2',
      senderId: 'me',
      content: 'أهلاً وسهلاً! بخير والحمد لله',
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
      type: MessageType.text,
      isRead: true,
    ),
    ChatMessage(
      id: '3',
      senderId: 'other',
      content: 'ما رأيك في التطبيق الجديد؟',
      timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
      type: MessageType.text,
      isRead: true,
    ),
    ChatMessage(
      id: '4',
      senderId: 'me',
      content: 'رائع جداً! أحب التصميم والميزات الجديدة',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      type: MessageType.text,
      isRead: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _lastSeen = DateTime.now().subtract(const Duration(minutes: 5));
    _scrollToBottom();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    final message = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'me',
      content: content,
      timestamp: DateTime.now(),
      type: MessageType.text,
      isRead: false,
    );

    setState(() {
      _messages.add(message);
      _messageController.clear();
    });

    _scrollToBottom();
  }

  void _showMessageOptions(ChatMessage message) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.copy),
              title: Text(AppLocalizations.of(context)!.copy),
              onTap: () {
                Navigator.pop(context);
                // Copy message to clipboard
              },
            ),
            if (message.senderId == 'me')
              ListTile(
                leading: const Icon(Icons.delete),
                title: Text(AppLocalizations.of(context)!.delete),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _messages.remove(message);
                  });
                },
              ),
            ListTile(
              leading: const Icon(Icons.reply),
              title: Text(AppLocalizations.of(context)!.reply),
              onTap: () {
                Navigator.pop(context);
                // Set reply message
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(widget.recipientAvatar),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserVerificationStatus(
                    isVerified: widget.isRecipientVerified,
                    userName: widget.recipientName,
                    badgeSize: 14,
                    nameStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _isRecipientOnline 
                        ? localizations.online
                        : localizations.isArabic 
                            ? 'آخر ظهور ${_formatLastSeen()}'
                            : 'Last seen ${_formatLastSeen()}',
                    style: TextStyle(
                      fontSize: 12,
                      color: _isRecipientOnline 
                          ? Colors.green 
                          : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              // Start video call
            },
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              // Start voice call
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'view_profile':
                  // Navigate to profile
                  break;
                case 'mute':
                  // Mute conversation
                  break;
                case 'block':
                  // Block user
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'view_profile',
                child: Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(width: 8),
                    Text(localizations.viewProfile),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'mute',
                child: Row(
                  children: [
                    const Icon(Icons.volume_off),
                    const SizedBox(width: 8),
                    Text(localizations.mute),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'block',
                child: Row(
                  children: [
                    const Icon(Icons.block),
                    const SizedBox(width: 8),
                    Text(localizations.block),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: OptimizedListViewBuilder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message.senderId == 'me';
                final showTimestamp = index == 0 || 
                    _messages[index - 1].timestamp.difference(message.timestamp).inMinutes.abs() > 5;
                
                return Column(
                  children: [
                    if (showTimestamp)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          _formatMessageTime(message.timestamp),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    _buildMessageBubble(message, isMe),
                  ],
                );
              },
            ),
          ),
          
          // Typing Indicator
          if (_isTyping)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(widget.recipientAvatar),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    localizations.isArabic ? 'يكتب...' : 'typing...',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          
          // Message Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    // Show attachment options
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    focusNode: _messageFocusNode,
                    decoration: InputDecoration(
                      hintText: localizations.typeMessage,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  mini: true,
                  onPressed: _sendMessage,
                  backgroundColor: TwitterColor.dodgerBlue,
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, bool isMe) {
    return GestureDetector(
      onLongPress: () => _showMessageOptions(message),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            color: isMe 
                ? TwitterColor.dodgerBlue 
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(18).copyWith(
              bottomRight: isMe ? const Radius.circular(4) : null,
              bottomLeft: !isMe ? const Radius.circular(4) : null,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.content,
                style: TextStyle(
                  color: isMe ? Colors.white : Theme.of(context).textTheme.bodyMedium?.color,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _formatMessageTime(message.timestamp, showDate: false),
                    style: TextStyle(
                      fontSize: 11,
                      color: isMe 
                          ? Colors.white.withOpacity(0.7)
                          : Colors.grey[600],
                    ),
                  ),
                  if (isMe) ...[
                    const SizedBox(width: 4),
                    Icon(
                      message.isRead ? Icons.done_all : Icons.done,
                      size: 14,
                      color: message.isRead 
                          ? Colors.blue[300]
                          : Colors.white.withOpacity(0.7),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatLastSeen() {
    if (_lastSeen == null) return '';
    
    final now = DateTime.now();
    final difference = now.difference(_lastSeen!);
    
    if (difference.inMinutes < 1) {
      return 'الآن';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} دقيقة';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ساعة';
    } else {
      return '${difference.inDays} يوم';
    }
  }

  String _formatMessageTime(DateTime timestamp, {bool showDate = true}) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (showDate && difference.inDays > 0) {
      return '${timestamp.day}/${timestamp.month} ${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else {
      return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
  }
}

enum MessageType {
  text,
  image,
  video,
  audio,
  file,
}

class ChatMessage {
  final String id;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final MessageType type;
  bool isRead;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.type,
    required this.isRead,
  });
}