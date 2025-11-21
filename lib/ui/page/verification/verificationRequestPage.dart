import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pix/l10n/app_localizations.dart';
import 'package:pix/state/authState.dart';
import 'package:pix/ui/theme/theme.dart';
import 'package:pix/widgets/customAppBar.dart';
import 'package:pix/widgets/customWidgets.dart';
import 'package:pix/model/verificationModel.dart';

class VerificationRequestPage extends StatefulWidget {
  const VerificationRequestPage({Key? key}) : super(key: key);

  static Route<T> getRoute<T>() {
    return MaterialPageRoute(
      builder: (_) => const VerificationRequestPage(),
    );
  }

  @override
  State<VerificationRequestPage> createState() => _VerificationRequestPageState();
}

class _VerificationRequestPageState extends State<VerificationRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  String _selectedCategory = 'public_figure';
  bool _isSubmitting = false;

  final List<Map<String, String>> _categories = [
    {'key': 'public_figure', 'title': 'Public Figure', 'titleAr': 'شخصية عامة'},
    {'key': 'business', 'title': 'Business', 'titleAr': 'أعمال'},
    {'key': 'government', 'title': 'Government', 'titleAr': 'حكومي'},
    {'key': 'media', 'title': 'Media', 'titleAr': 'إعلام'},
    {'key': 'sports', 'title': 'Sports', 'titleAr': 'رياضة'},
    {'key': 'entertainment', 'title': 'Entertainment', 'titleAr': 'ترفيه'},
    {'key': 'other', 'title': 'Other', 'titleAr': 'أخرى'},
  ];

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final authState = Provider.of<AuthState>(context, listen: false);
      final user = authState.userModel;
      
      if (user == null) {
        _showErrorDialog('User not found');
        return;
      }

      final verification = VerificationModel(
        userId: user.userId,
        userName: user.userName,
        userEmail: user.email,
        reason: _reasonController.text.trim(),
        category: _selectedCategory,
        submittedAt: DateTime.now().toIso8601String(),
        status: 'pending',
      );

      // Here you would typically save to Firebase
      // await FirebaseService.submitVerificationRequest(verification);

      _showSuccessDialog();
    } catch (e) {
      _showErrorDialog('Failed to submit request: $e');
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void _showSuccessDialog() {
    final localizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.done),
        content: Text(
          localizations.isArabic
            ? 'تم إرسال طلب التوثيق بنجاح. سيتم مراجعته خلال 3-5 أيام عمل.'
            : 'Verification request submitted successfully. It will be reviewed within 3-5 business days.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(localizations.ok),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.error),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.ok),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: TwitterColor.mystic,
      appBar: CustomAppBar(
        isBackButton: true,
        title: localizations.requestVerification,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.verified,
                          color: TwitterColor.dodgerBlue,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          localizations.verified,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      localizations.isArabic
                        ? 'العلامة الزرقاء تؤكد أن الحساب أصلي ومهم وموثوق. للحصول على التوثيق، يجب أن يكون حسابك نشطاً وأن تقدم معلومات صحيحة.'
                        : 'The blue checkmark confirms that an account is authentic, notable, and trustworthy. To get verified, your account must be active and provide accurate information.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Category Selection
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.isArabic ? 'الفئة' : 'Category',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      items: _categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category['key'],
                          child: Text(
                            localizations.isArabic 
                              ? category['titleAr']! 
                              : category['title']!,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Reason Text Field
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.verificationReason,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _reasonController,
                      maxLines: 5,
                      maxLength: 500,
                      decoration: InputDecoration(
                        hintText: localizations.isArabic
                          ? 'اشرح لماذا يجب توثيق حسابك. قدم تفاصيل حول هويتك أو عملك أو إنجازاتك.'
                          : 'Explain why your account should be verified. Provide details about your identity, work, or achievements.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return localizations.isArabic
                            ? 'يرجى إدخال سبب طلب التوثيق'
                            : 'Please enter a reason for verification';
                        }
                        if (value.trim().length < 50) {
                          return localizations.isArabic
                            ? 'يجب أن يكون السبب 50 حرفاً على الأقل'
                            : 'Reason must be at least 50 characters';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TwitterColor.dodgerBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        localizations.submitVerificationRequest,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Disclaimer
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.orange.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.orange[700],
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        localizations.isArabic
                          ? 'ملاحظة: لا يضمن تقديم طلب التوثيق الحصول على العلامة الزرقاء. سيتم مراجعة جميع الطلبات بعناية.'
                          : 'Note: Submitting a verification request does not guarantee receiving the blue checkmark. All requests will be carefully reviewed.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange[700],
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}