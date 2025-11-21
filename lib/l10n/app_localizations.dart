import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  bool get isArabic => locale.languageCode == 'ar';

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en', ''),
    Locale('ar', ''),
  ];

  // Common
  String get appName => _localizedValues[locale.languageCode]!['app_name']!;
  String get ok => _localizedValues[locale.languageCode]!['ok']!;
  String get cancel => _localizedValues[locale.languageCode]!['cancel']!;
  String get save => _localizedValues[locale.languageCode]!['save']!;
  String get delete => _localizedValues[locale.languageCode]!['delete']!;
  String get edit => _localizedValues[locale.languageCode]!['edit']!;
  String get loading => _localizedValues[locale.languageCode]!['loading']!;
  String get error => _localizedValues[locale.languageCode]!['error']!;
  String get retry => _localizedValues[locale.languageCode]!['retry']!;
  String get done => _localizedValues[locale.languageCode]!['done']!;
  String get next => _localizedValues[locale.languageCode]!['next']!;
  String get back => _localizedValues[locale.languageCode]!['back']!;
  String get close => _localizedValues[locale.languageCode]!['close']!;
  String get search => _localizedValues[locale.languageCode]!['search']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get profile => _localizedValues[locale.languageCode]!['profile']!;
  String get home => _localizedValues[locale.languageCode]!['home']!;
  String get notifications => _localizedValues[locale.languageCode]!['notifications']!;
  String get messages => _localizedValues[locale.languageCode]!['messages']!;

  // Authentication
  String get signIn => _localizedValues[locale.languageCode]!['sign_in']!;
  String get signUp => _localizedValues[locale.languageCode]!['sign_up']!;
  String get signOut => _localizedValues[locale.languageCode]!['sign_out']!;
  String get email => _localizedValues[locale.languageCode]!['email']!;
  String get password => _localizedValues[locale.languageCode]!['password']!;
  String get confirmPassword => _localizedValues[locale.languageCode]!['confirm_password']!;
  String get forgotPassword => _localizedValues[locale.languageCode]!['forgot_password']!;
  String get createAccount => _localizedValues[locale.languageCode]!['create_account']!;
  String get alreadyHaveAccount => _localizedValues[locale.languageCode]!['already_have_account']!;
  String get dontHaveAccount => _localizedValues[locale.languageCode]!['dont_have_account']!;
  String get signInWithGoogle => _localizedValues[locale.languageCode]!['sign_in_with_google']!;
  String get fullName => _localizedValues[locale.languageCode]!['full_name']!;
  String get username => _localizedValues[locale.languageCode]!['username']!;

  // Posts/Tweets
  String get post => _localizedValues[locale.languageCode]!['post']!;
  String get tweet => _localizedValues[locale.languageCode]!['tweet']!;
  String get retweet => _localizedValues[locale.languageCode]!['retweet']!;
  String get like => _localizedValues[locale.languageCode]!['like']!;
  String get reply => _localizedValues[locale.languageCode]!['reply']!;
  String get share => _localizedValues[locale.languageCode]!['share']!;
  String get bookmark => _localizedValues[locale.languageCode]!['bookmark']!;
  String get whatsHappening => _localizedValues[locale.languageCode]!['whats_happening']!;
  String get addPhoto => _localizedValues[locale.languageCode]!['add_photo']!;
  String get addVideo => _localizedValues[locale.languageCode]!['add_video']!;
  String get postTweet => _localizedValues[locale.languageCode]!['post_tweet']!;

  // Profile
  String get editProfile => _localizedValues[locale.languageCode]!['edit_profile']!;
  String get followers => _localizedValues[locale.languageCode]!['followers']!;
  String get following => _localizedValues[locale.languageCode]!['following']!;
  String get follow => _localizedValues[locale.languageCode]!['follow']!;
  String get unfollow => _localizedValues[locale.languageCode]!['unfollow']!;
  String get bio => _localizedValues[locale.languageCode]!['bio']!;
  String get location => _localizedValues[locale.languageCode]!['location']!;
  String get website => _localizedValues[locale.languageCode]!['website']!;
  String get joinedDate => _localizedValues[locale.languageCode]!['joined_date']!;
  String get verified => _localizedValues[locale.languageCode]!['verified']!;
  String get requestVerification => _localizedValues[locale.languageCode]!['request_verification']!;

  // Settings
  String get accountSettings => _localizedValues[locale.languageCode]!['account_settings']!;
  String get privacySettings => _localizedValues[locale.languageCode]!['privacy_settings']!;
  String get notificationSettings => _localizedValues[locale.languageCode]!['notification_settings']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get theme => _localizedValues[locale.languageCode]!['theme']!;
  String get darkMode => _localizedValues[locale.languageCode]!['dark_mode']!;
  String get lightMode => _localizedValues[locale.languageCode]!['light_mode']!;
  String get about => _localizedValues[locale.languageCode]!['about']!;
  String get help => _localizedValues[locale.languageCode]!['help']!;
  String get termsOfService => _localizedValues[locale.languageCode]!['terms_of_service']!;
  String get privacyPolicy => _localizedValues[locale.languageCode]!['privacy_policy']!;

  // Verification
  String get verificationRequest => _localizedValues[locale.languageCode]!['verification_request']!;
  String get verificationPending => _localizedValues[locale.languageCode]!['verification_pending']!;
  String get verificationApproved => _localizedValues[locale.languageCode]!['verification_approved']!;
  String get verificationRejected => _localizedValues[locale.languageCode]!['verification_rejected']!;
  String get submitVerificationRequest => _localizedValues[locale.languageCode]!['submit_verification_request']!;
  String get verificationReason => _localizedValues[locale.languageCode]!['verification_reason']!;

  // Error Messages
  String get networkError => _localizedValues[locale.languageCode]!['network_error']!;
  String get serverError => _localizedValues[locale.languageCode]!['server_error']!;
  String get invalidEmail => _localizedValues[locale.languageCode]!['invalid_email']!;
  String get weakPassword => _localizedValues[locale.languageCode]!['weak_password']!;
  String get passwordMismatch => _localizedValues[locale.languageCode]!['password_mismatch']!;
  String get userNotFound => _localizedValues[locale.languageCode]!['user_not_found']!;
  String get wrongPassword => _localizedValues[locale.languageCode]!['wrong_password']!;
  String get emailAlreadyInUse => _localizedValues[locale.languageCode]!['email_already_in_use']!;

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_name': 'Pix',
      'ok': 'OK',
      'cancel': 'Cancel',
      'save': 'Save',
      'delete': 'Delete',
      'edit': 'Edit',
      'loading': 'Loading...',
      'error': 'Error',
      'retry': 'Retry',
      'done': 'Done',
      'next': 'Next',
      'back': 'Back',
      'close': 'Close',
      'search': 'Search',
      'settings': 'Settings',
      'profile': 'Profile',
      'home': 'Home',
      'notifications': 'Notifications',
      'messages': 'Messages',
      
      // Authentication
      'sign_in': 'Sign In',
      'sign_up': 'Sign Up',
      'sign_out': 'Sign Out',
      'email': 'Email',
      'password': 'Password',
      'confirm_password': 'Confirm Password',
      'forgot_password': 'Forgot Password?',
      'create_account': 'Create Account',
      'already_have_account': 'Already have an account?',
      'dont_have_account': "Don't have an account?",
      'sign_in_with_google': 'Sign in with Google',
      'full_name': 'Full Name',
      'username': 'Username',
      
      // Posts/Tweets
      'post': 'Post',
      'tweet': 'Tweet',
      'retweet': 'Retweet',
      'like': 'Like',
      'reply': 'Reply',
      'share': 'Share',
      'bookmark': 'Bookmark',
      'whats_happening': "What's happening?",
      'add_photo': 'Add Photo',
      'add_video': 'Add Video',
      'post_tweet': 'Post Tweet',
      
      // Profile
      'edit_profile': 'Edit Profile',
      'followers': 'Followers',
      'following': 'Following',
      'follow': 'Follow',
      'unfollow': 'Unfollow',
      'bio': 'Bio',
      'location': 'Location',
      'website': 'Website',
      'joined_date': 'Joined',
      'verified': 'Verified',
      'request_verification': 'Request Verification',
      
      // Settings
      'account_settings': 'Account Settings',
      'privacy_settings': 'Privacy Settings',
      'notification_settings': 'Notification Settings',
      'language': 'Language',
      'theme': 'Theme',
      'dark_mode': 'Dark Mode',
      'light_mode': 'Light Mode',
      'about': 'About',
      'help': 'Help',
      'terms_of_service': 'Terms of Service',
      'privacy_policy': 'Privacy Policy',
      
      // Verification
      'verification_request': 'Verification Request',
      'verification_pending': 'Verification Pending',
      'verification_approved': 'Verification Approved',
      'verification_rejected': 'Verification Rejected',
      'submit_verification_request': 'Submit Verification Request',
      'verification_reason': 'Reason for Verification',
      
      // Error Messages
      'network_error': 'Network error. Please check your connection.',
      'server_error': 'Server error. Please try again later.',
      'invalid_email': 'Please enter a valid email address.',
      'weak_password': 'Password should be at least 6 characters.',
      'password_mismatch': 'Passwords do not match.',
      'user_not_found': 'User not found.',
      'wrong_password': 'Wrong password.',
      'email_already_in_use': 'Email is already in use.',
    },
    'ar': {
      'app_name': 'بيكس',
      'ok': 'موافق',
      'cancel': 'إلغاء',
      'save': 'حفظ',
      'delete': 'حذف',
      'edit': 'تعديل',
      'loading': 'جاري التحميل...',
      'error': 'خطأ',
      'retry': 'إعادة المحاولة',
      'done': 'تم',
      'next': 'التالي',
      'back': 'رجوع',
      'close': 'إغلاق',
      'search': 'بحث',
      'settings': 'الإعدادات',
      'profile': 'الملف الشخصي',
      'home': 'الرئيسية',
      'notifications': 'الإشعارات',
      'messages': 'الرسائل',
      
      // Authentication
      'sign_in': 'تسجيل الدخول',
      'sign_up': 'إنشاء حساب',
      'sign_out': 'تسجيل الخروج',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'confirm_password': 'تأكيد كلمة المرور',
      'forgot_password': 'نسيت كلمة المرور؟',
      'create_account': 'إنشاء حساب',
      'already_have_account': 'لديك حساب بالفعل؟',
      'dont_have_account': 'ليس لديك حساب؟',
      'sign_in_with_google': 'تسجيل الدخول بواسطة جوجل',
      'full_name': 'الاسم الكامل',
      'username': 'اسم المستخدم',
      
      // Posts/Tweets
      'post': 'منشور',
      'tweet': 'تغريدة',
      'retweet': 'إعادة تغريد',
      'like': 'إعجاب',
      'reply': 'رد',
      'share': 'مشاركة',
      'bookmark': 'إشارة مرجعية',
      'whats_happening': 'ماذا يحدث؟',
      'add_photo': 'إضافة صورة',
      'add_video': 'إضافة فيديو',
      'post_tweet': 'نشر التغريدة',
      
      // Profile
      'edit_profile': 'تعديل الملف الشخصي',
      'followers': 'المتابعون',
      'following': 'يتابع',
      'follow': 'متابعة',
      'unfollow': 'إلغاء المتابعة',
      'bio': 'النبذة الشخصية',
      'location': 'الموقع',
      'website': 'الموقع الإلكتروني',
      'joined_date': 'انضم في',
      'verified': 'موثق',
      'request_verification': 'طلب التوثيق',
      
      // Settings
      'account_settings': 'إعدادات الحساب',
      'privacy_settings': 'إعدادات الخصوصية',
      'notification_settings': 'إعدادات الإشعارات',
      'language': 'اللغة',
      'theme': 'المظهر',
      'dark_mode': 'الوضع المظلم',
      'light_mode': 'الوضع الفاتح',
      'about': 'حول',
      'help': 'المساعدة',
      'terms_of_service': 'شروط الخدمة',
      'privacy_policy': 'سياسة الخصوصية',
      
      // Verification
      'verification_request': 'طلب التوثيق',
      'verification_pending': 'التوثيق قيد المراجعة',
      'verification_approved': 'تم قبول التوثيق',
      'verification_rejected': 'تم رفض التوثيق',
      'submit_verification_request': 'إرسال طلب التوثيق',
      'verification_reason': 'سبب طلب التوثيق',
      
      // Error Messages
      'network_error': 'خطأ في الشبكة. يرجى التحقق من الاتصال.',
      'server_error': 'خطأ في الخادم. يرجى المحاولة لاحقاً.',
      'invalid_email': 'يرجى إدخال عنوان بريد إلكتروني صحيح.',
      'weak_password': 'يجب أن تكون كلمة المرور 6 أحرف على الأقل.',
      'password_mismatch': 'كلمات المرور غير متطابقة.',
      'user_not_found': 'المستخدم غير موجود.',
      'wrong_password': 'كلمة مرور خاطئة.',
      'email_already_in_use': 'البريد الإلكتروني مستخدم بالفعل.',
    },
  };
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}