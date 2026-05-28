// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'التطبيق الاحترافي';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get signup => 'إنشاء حساب';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get emptyFieldError => 'لا يمكن أن يكون هذا الحقل فارغاً';

  @override
  String get invalidEmailError => 'الرجاء إدخال بريد إلكتروني صحيح';

  @override
  String get weakPasswordError =>
      'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';

  @override
  String get passwordMismatchError => 'كلمات المرور غير متطابقة';

  @override
  String get submit => 'إرسال';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get successLogin => 'تم تسجيل الدخول بنجاح!';

  @override
  String get successSignup => 'تم إنشاء الحساب بنجاح!';

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String get loginToContinue => 'قم بتسجيل الدخول للمتابعة';

  @override
  String get createAnAccount => 'إنشاء حساب جديد';
}
