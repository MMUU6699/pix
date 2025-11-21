import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/helper/enum.dart';
import 'package:flutter_twitter_clone/helper/utility.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:flutter_twitter_clone/ui/page/Auth/selectAuthMethod.dart';
import 'package:flutter_twitter_clone/ui/page/homePage.dart';
import 'package:flutter_twitter_clone/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer();
    });
    super.initState();
  }

  /// Check if current app is updated app or not
  /// If app is not updated then redirect user to update app screen
  void timer() async {
    final isAppUpdated = await _checkAppVersion();
    if (isAppUpdated) {
      cprint("App is updated");
      Future.delayed(const Duration(seconds: 1)).then((_) {
        var state = Provider.of<AuthState>(context, listen: false);
        state.getCurrentUser();
      });
    }
  }

  /// Return installed app version
  /// For testing purpose in debug mode update screen will not be open up
  /// If an old version of app is installed on user's device then
  /// User will not be able to see home screen
  /// User will redirected to update app screen.
  /// Once user update app with latest version and back to app then user automatically redirected to welcome / Home page
  Future<bool> _checkAppVersion() async {
    // تجاوز التحقق من التحديث دائماً وتوجيه المستخدم للشاشة الرئيسية
    cprint("تخطي التحقق من التحديث: سيتم توجيه المستخدم مباشرة إلى الشاشة الرئيسية");
    return true;
  }

  /// Returns app version from firebase config
  /// Fetch Latest app version from firebase Remote config
  /// To check current installed app version check [version] in pubspec.yaml
  /// you have to add latest app version in firebase remote config
  /// To fetch this key go to project setting in firebase
  /// Open `Remote Config` section in Firebase
  /// Add [supportedBuild]  as parameter key and below json in Default value
  ///  ```
  ///  {
  ///    "supportedBuild":
  ///    {
  ///       "name": "<Current Build Version>","
  ///       "versions": [ <Current Build Version> ]
  ///     }
  ///  } ```
  /// After adding app version key click on Publish Change button
  /// For package detail check:-  https://pub.dev/packages/firebase_remote_config#-readme-tab-

  Widget _body() {
    var height = 150.0;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Container(
        height: height,
        width: height,
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(50),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Platform.isIOS
                  ? const CupertinoActivityIndicator(
                      radius: 35,
                    )
                  : const CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
              Image.asset(
                'assets/images/icon-480.png',
                height: 30,
                width: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context);
    return Scaffold(
      backgroundColor: TwitterColor.white,
      body: state.authStatus == AuthStatus.NOT_DETERMINED
          ? _body()
          : state.authStatus == AuthStatus.NOT_LOGGED_IN
              ? const WelcomePage()
              : const HomePage(),
    );
  }
}
