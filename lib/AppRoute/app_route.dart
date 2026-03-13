import 'package:fin_wise/AppRoute/app_route_path.dart';
import 'package:fin_wise/Model/categorie_model.dart';
import 'package:fin_wise/Screens/AccountBalance/AccountBalanceScreen/account_balance_screen.dart';
import 'package:fin_wise/Screens/AuthScreens/login_screen.dart';
import 'package:fin_wise/Screens/AuthScreens/new_password_screen.dart';
import 'package:fin_wise/Screens/BottomNavScreens/Analysis/AnalysisScreen/analysis_screen.dart';
import 'package:fin_wise/Screens/BottomNavScreens/Categories/CategoriesScreen/categories_detail_screen.dart';
import 'package:fin_wise/Screens/BottomNavScreens/Home/HomeScreen/home_screen.dart';
import 'package:fin_wise/Screens/Search/SearchScreen/search_screen.dart';
import 'package:go_router/go_router.dart';
import '../Screens/AuthScreens/fingerprint_screen.dart';
import '../Screens/AuthScreens/forgot_password_screen.dart';
import '../Screens/AuthScreens/otp_screen.dart';
import '../Screens/AuthScreens/signup_screen.dart';
import '../Screens/AuthScreens/successfully_password_screen.dart';
import '../Screens/BottomNavScreens/Categories/CategoriesScreen/add_expense_screen.dart';
import '../Screens/BottomNavScreens/Categories/CategoriesScreen/categories_screen.dart';
import '../Screens/BottomNavScreens/Profile/ProfileScreen/profile_screen.dart';
import '../Screens/BottomNavScreens/Transaction/TransactionScreen/transaction_screen.dart';
import '../Screens/Calender/CalenderScreen/calender_screen.dart';
import '../Screens/Notification/NotificationScreen/notification_screen.dart';
import '../Screens/OnboardingScreen/onboarding_screen.dart';
import '../Screens/QuicklyAnalysis/QuicklyAnalysisScreen/quickly_analysis_screen.dart';
import '../Screens/Splash/splash_screen.dart';
import '../Screens/Welcome_screen/launch_screen.dart';
import '../Utilites/GlobalWidgets/BottomNavBar/bottom_navigation_bar.dart';

GoRouter appRoute = GoRouter(
  initialLocation: AppRoutePath.splashScreen.path,
  routes: [
    GoRoute(
      path: AppRoutePath.splashScreen.path,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: AppRoutePath.launchScreen.path,
      builder: (context, state) => LaunchScreen(),
    ),
    GoRoute(
      path: AppRoutePath.onboardingScreen.path,
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutePath.loginScreen.path,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: AppRoutePath.signupScreen.path,
      builder: (context, state) => SignupScreen(),
    ),
    GoRoute(
      path: AppRoutePath.forgotPasswordScreen.path,
      builder: (context, state) => ForgotPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutePath.otpScreen.path,
      builder: (context, state) => OtpScreen(),
    ),
    GoRoute(
      path: AppRoutePath.newPasswordScreen.path,
      builder: (context, state) => NewPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutePath.successfullyPasswordScreen.path,
      builder: (context, state) => SuccessfullyPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutePath.fingerprintScreen.path,
      builder: (context, state) =>FingerprintScreen()
    ),
    GoRoute(
      path: AppRoutePath.notificationScreen.path,
      builder: (context, state) => NotificationScreen(),
    ),
    GoRoute(
      path: AppRoutePath.accountBalanceScreen.path,
      builder: (context, state) => AccountBalanceScreen(),
    ),
    GoRoute(
      path: AppRoutePath.quicklyAnalysisScreen.path,
      builder: (context, state) => QuicklyAnalysisScreen(),
    ),
    GoRoute(
      path: AppRoutePath.searchScreen.path,
      builder: (context, state) => SearchScreen(),
    ),
    GoRoute(
      path: AppRoutePath.calenderScreen.path,
      builder: (context, state) => CalenderScreen(),
    ),  GoRoute(
      path: AppRoutePath.addExpenseScreen.path,
      builder: (context, state) {
        final cateId = state.extra as String;

       return AddExpenseScreen(cateId: cateId);
}
    ),
    GoRoute(
      path: AppRoutePath.categoriesDetailScreen.path,
      builder: (context, state) {
        final categoryIndex = state.extra as CategorieModel;
        return CategoriesDetailScreen(category: categoryIndex);
      },
    ),

    ShellRoute(
      builder: (context, state, child) {
        return BottomNavigationBarWidget(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutePath.homeScreen.path,
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: AppRoutePath.analysisScreen.path,
          builder: (context, state) => AnalysisScreen(),
        ),
        GoRoute(
          path: AppRoutePath.transactionScreen.path,
          builder: (context, state) => TransactionScreen(),
        ),
        GoRoute(
          path: AppRoutePath.categoriesScreen.path,
          builder: (context, state) => CategoriesScreen(),
        ),
        GoRoute(
          path: AppRoutePath.profileScreen.path,
          builder: (context, state) => ProfileScreen(),
        ),
      ],
    ),
  ],
);
