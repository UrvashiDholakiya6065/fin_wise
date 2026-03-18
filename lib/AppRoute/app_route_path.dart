

enum AppRoutePath {
  splashScreen('/','SplashScreen'),
  launchScreen('/LaunchScreen','LaunchScreen'),
  onboardingScreen('/OnboardingScreen','OnboardingScreen'),
  loginScreen('/LoginScreen','LoginScreen'),
  signupScreen('/SignupScreen','SignupScreen'),
  forgotPasswordScreen('/ForgotPasswordScreen','ForgotPasswordScreen'),
  otpScreen('/OtpScreen','OtpScreen'),
  newPasswordScreen('/NewPasswordScreen','NewPasswordScreen'),
  successfullyPasswordScreen('/SuccessfullyPasswordScreen','SuccessfullyPasswordScreen'),
  fingerprintScreen('/FingerprintScreen','FingerprintScreen'),
  homeScreen('/HomeScreen','HomeScreen'),
  analysisScreen('/AnalysisScreen','AnalysisScreen'),
  transactionScreen('/TransactionScreen','TransactionScreen'),
  categoriesScreen('/CategoriesScreen','CategoriesScreen'),
  profileScreen('/ProfileScreen','ProfileScreen'),
  notificationScreen('/NotificationScreen','NotificationScreen'),
  accountBalanceScreen('/AccountBalanceScreen','AccountBalanceScreen'),
  quicklyAnalysisScreen('/QuicklyAnalysisScreen','QuicklyAnalysisScreen'),
  searchScreen('/SearchScreen','SearchScreen'),
  calenderScreen('/CalenderScreen','CalenderScreen'),
  categoriesDetailScreen('/CategoriesDetailScreen','CategoriesDetailScreen'),
  addExpenseScreen('/AddExpenseScreen','AddExpenseScreen'),
  addBalanceScreen('/AddBalanceScreen','AddBalanceScreen'),
  editProfileScreen('/EditProfile','EditProfile'),
  settingScreen('/SettingScreen','SettingScreen'),
  notificationSettingScreen('/NotificationSettingScreen','NotificationSettingScreen'),
  passwordSettingScreen('/PasswordSettingScreen','PasswordSettingScreen');

  final String path;
  final String name;

  const AppRoutePath(this.path,this.name);
}