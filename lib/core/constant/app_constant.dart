class AppConstants {
  static const String appTitle = 'Riverpod Login Demo';
  static const int minPasswordLength = 6;
  static const int loginDelay = 2; // seconds

  static const List<String> genderOptions = [
    'Male',
    'Female',
    'Other',
    'Prefer not to say',
  ];
}

class AppStrings {
  static const String welcomeBack = 'Welcome Back';
  static const String loginToContinue = 'Login to continue';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String gender = 'Gender';
  static const String rememberMe = 'Remember me';
  static const String forgotPassword = 'Forgot Password?';
  static const String login = 'Login';
  static const String logout = 'Logout';
  static const String home = 'Home';
  static const String youWillBeRemembered = 'You will be remembered';
  static const String successfullyLoggedIn = 'You are successfully logged in!';

  // Hints
  static const String enterEmail = 'Enter your email';
  static const String enterPassword = 'Enter your password';
  static const String selectGender = 'Select your gender';

  // Errors
  static const String emailPasswordEmpty = 'Email and password cannot be empty';
  static const String invalidEmail = 'Please enter a valid email';
  static const String passwordTooShort = 'Password must be at least 6 characters';
  static const String selectGenderError = 'Please select your gender';
}