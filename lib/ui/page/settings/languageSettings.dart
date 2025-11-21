import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pix/l10n/app_localizations.dart';
import 'package:pix/state/languageState.dart';
import 'package:pix/ui/theme/theme.dart';
import 'package:pix/widgets/customAppBar.dart';

class LanguageSettingsPage extends StatelessWidget {
  const LanguageSettingsPage({Key? key}) : super(key: key);

  static Route<T> getRoute<T>() {
    return MaterialPageRoute(
      builder: (_) => const LanguageSettingsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: TwitterColor.mystic,
      appBar: CustomAppBar(
        isBackButton: true,
        title: localizations.language,
      ),
      body: Consumer<LanguageState>(
        builder: (context, languageState, child) {
          return ListView(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    _buildLanguageTile(
                      context,
                      title: 'English',
                      subtitle: 'English',
                      isSelected: languageState.isEnglish,
                      onTap: () => languageState.changeLanguage('en'),
                    ),
                    const Divider(height: 0),
                    _buildLanguageTile(
                      context,
                      title: 'العربية',
                      subtitle: 'Arabic',
                      isSelected: languageState.isArabic,
                      onTap: () => languageState.changeLanguage('ar'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Text(
                  languageState.isArabic 
                    ? 'سيتم تطبيق تغيير اللغة على التطبيق بالكامل.'
                    : 'Language changes will be applied to the entire app.',
                  style: TextStyle(
                    color: Colors.grey[600],
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

  Widget _buildLanguageTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check,
              color: TwitterColor.dodgerBlue,
            )
          : null,
      onTap: onTap,
    );
  }
}