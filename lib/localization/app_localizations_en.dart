// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Professional App';

  @override
  String get login => 'Login';

  @override
  String get signup => 'Sign Up';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get emptyFieldError => 'This field cannot be empty';

  @override
  String get invalidEmailError => 'Please enter a valid email';

  @override
  String get weakPasswordError => 'Password must be at least 6 characters';

  @override
  String get passwordMismatchError => 'Passwords do not match';

  @override
  String get submit => 'Submit';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get successLogin => 'Successfully logged in!';

  @override
  String get successSignup => 'Successfully signed up!';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get loginToContinue => 'Login to continue';

  @override
  String get createAnAccount => 'Create an account';
}
