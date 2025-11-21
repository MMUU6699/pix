import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pix/state/suggestionUserState.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:pix/state/searchState.dart';
import 'package:pix/ui/page/common/locator.dart';
import 'package:pix/ui/theme/theme.dart';
import 'package:pix/l10n/app_localizations.dart';

import 'helper/routes.dart';
import 'state/appState.dart';
import 'state/authState.dart';
import 'state/chats/chatState.dart';
import 'state/feedState.dart';
import 'state/notificationState.dart';
import 'state/languageState.dart';
import 'state/themeState.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase with error handling
  try {
    await Firebase.initializeApp();
    print('✅ Firebase initialized successfully');
  } catch (e) {
    print('⚠️ Firebase initialization failed: $e');
    print('📱 App will continue without Firebase features');
  }
  
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (_) => AppState()),
        ChangeNotifierProvider<AuthState>(create: (_) => AuthState()),
        ChangeNotifierProvider<FeedState>(create: (_) => FeedState()),
        ChangeNotifierProvider<ChatState>(create: (_) => ChatState()),
        ChangeNotifierProvider<SearchState>(create: (_) => SearchState()),
        ChangeNotifierProvider<NotificationState>(
            create: (_) => NotificationState()),
        ChangeNotifierProvider<SuggestionsState>(
            create: (_) => SuggestionsState()),
        ChangeNotifierProvider<LanguageState>(
            create: (_) => LanguageState()),
        ChangeNotifierProvider<ThemeState>(
            create: (_) => ThemeState()),
      ],
      child: Consumer2<LanguageState, ThemeState>(
        builder: (context, languageState, themeState, child) {
          return MaterialApp(
            title: 'Pix',
            theme: AppTheme.lightTheme.copyWith(
              textTheme: GoogleFonts.mulishTextTheme(
                AppTheme.lightTheme.textTheme,
              ),
            ),
            darkTheme: AppTheme.darkTheme.copyWith(
              textTheme: GoogleFonts.mulishTextTheme(
                AppTheme.darkTheme.textTheme,
              ),
            ),
            themeMode: themeState.themeMode,
            debugShowCheckedModeBanner: false,
            locale: languageState.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            routes: Routes.route(),
            onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
            onUnknownRoute: (settings) => Routes.onUnknownRoute(settings),
            initialRoute: "SplashPage",
          );
        },
      ),
    );
  }
}
