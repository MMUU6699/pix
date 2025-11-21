import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pix/l10n/app_localizations.dart';
import 'package:pix/state/themeState.dart';
import 'package:pix/ui/theme/theme.dart';
import 'package:pix/widgets/customAppBar.dart';

class ThemeSettingsPage extends StatelessWidget {
  const ThemeSettingsPage({Key? key}) : super(key: key);

  static Route<T> getRoute<T>() {
    return MaterialPageRoute(
      builder: (_) => const ThemeSettingsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        isBackButton: true,
        title: localizations.theme,
      ),
      body: Consumer<ThemeState>(
        builder: (context, themeState, child) {
          return ListView(
            children: [
              Container(
                color: Theme.of(context).cardColor,
                child: Column(
                  children: [
                    _buildThemeTile(
                      context,
                      title: localizations.lightMode,
                      subtitle: localizations.isArabic 
                        ? 'مظهر فاتح مع خلفية بيضاء'
                        : 'Light theme with white background',
                      icon: Icons.light_mode,
                      isSelected: themeState.isLightMode,
                      onTap: () => themeState.setTheme(ThemeMode.light),
                    ),
                    const Divider(height: 0),
                    _buildThemeTile(
                      context,
                      title: localizations.darkMode,
                      subtitle: localizations.isArabic 
                        ? 'مظهر مظلم مع خلفية داكنة'
                        : 'Dark theme with dark background',
                      icon: Icons.dark_mode,
                      isSelected: themeState.isDarkMode,
                      onTap: () => themeState.setTheme(ThemeMode.dark),
                    ),
                    const Divider(height: 0),
                    _buildThemeTile(
                      context,
                      title: localizations.isArabic ? 'تلقائي' : 'System',
                      subtitle: localizations.isArabic 
                        ? 'يتبع إعدادات النظام'
                        : 'Follow system settings',
                      icon: Icons.settings_system_daydream,
                      isSelected: themeState.isSystemMode,
                      onTap: () => themeState.setTheme(ThemeMode.system),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.isArabic ? 'معاينة' : 'Preview',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildPreviewCard(context),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(16),
                child: Text(
                  localizations.isArabic 
                    ? 'سيتم تطبيق تغيير المظهر على التطبيق بالكامل فوراً.'
                    : 'Theme changes will be applied to the entire app immediately.',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildThemeTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected 
          ? TwitterColor.dodgerBlue 
          : Theme.of(context).iconTheme.color,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isSelected 
            ? TwitterColor.dodgerBlue 
            : Theme.of(context).textTheme.titleMedium?.color,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: TwitterColor.dodgerBlue,
            )
          : null,
      onTap: onTap,
    );
  }

  Widget _buildPreviewCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: TwitterColor.dodgerBlue,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'John Doe',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.titleMedium?.color,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.verified,
                          size: 16,
                          color: TwitterColor.dodgerBlue,
                        ),
                      ],
                    ),
                    Text(
                      '@johndoe',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'This is a sample post to show how the theme looks in the app. The colors and styling will change based on your theme selection.',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildPreviewAction(context, Icons.chat_bubble_outline, '12'),
              const SizedBox(width: 20),
              _buildPreviewAction(context, Icons.repeat, '5'),
              const SizedBox(width: 20),
              _buildPreviewAction(context, Icons.favorite_border, '24'),
              const SizedBox(width: 20),
              _buildPreviewAction(context, Icons.share_outlined, ''),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewAction(BuildContext context, IconData icon, String count) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
        ),
        if (count.isNotEmpty) ...[
          const SizedBox(width: 4),
          Text(
            count,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
            ),
          ),
        ],
      ],
    );
  }
}