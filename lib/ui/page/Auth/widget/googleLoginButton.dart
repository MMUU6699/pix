import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pix/helper/utility.dart';
import 'package:pix/state/authState.dart';
import 'package:pix/state/languageState.dart';
import 'package:pix/l10n/app_localizations.dart';
import 'package:pix/widgets/newWidget/customLoader.dart';
import 'package:pix/widgets/newWidget/rippleButton.dart';
import 'package:pix/widgets/newWidget/title_text.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({
    Key? key,
    required this.loader,
    this.loginCallback,
  }) : super(key: key);
  final CustomLoader loader;
  final Function? loginCallback;
  void _googleLogin(context) {
    var state = Provider.of<AuthState>(context, listen: false);
    loader.showLoader(context);
    state.handleGoogleSignIn().then((status) {
      // print(status)
      if (state.user != null) {
        loader.hideLoader();
        Navigator.pop(context);
        if (loginCallback != null) loginCallback!();
      } else {
        loader.hideLoader();
        cprint('Unable to login', errorIn: '_googleLoginButton');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Consumer<AuthState>(
      builder: (context, authState, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: RippleButton(
            onPressed: authState.isBusy ? null : () {
              _googleLogin(context);
            },
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (authState.isBusy) ...[
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ] else ...[
                    Image.asset(
                      'assets/images/google_logo.png',
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 12),
                  ],
                  TitleText(
                    authState.isBusy 
                      ? (localizations.isArabic ? 'جاري التسجيل...' : 'Signing in...')
                      : localizations.signInWithGoogle,
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
