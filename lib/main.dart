import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/Bloc/AuthBloc/auth_bloc.dart';
import 'package:fin_wise/Bloc/CategorieBloc/categorie_bloc.dart';
import 'package:fin_wise/Bloc/ExpenseBloc/expense_bloc.dart';
import 'package:fin_wise/Bloc/LanguageBloc/language_state.dart';
import 'package:fin_wise/Bloc/OnboardingBloc/onboarding_bloc.dart';
import 'package:fin_wise/Network/Services/notification_service.dart';
import 'package:fin_wise/SessionManage/shared_pref.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/BiomatricService/biomatric_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/BottomNavBloc/bottom_nav_bloc.dart';
import 'Bloc/LanguageBloc/language_bloc.dart';
import 'Bloc/LanguageBloc/language_event.dart';
import 'Bloc/NotificatioBloc/notification_bloc.dart';
import 'Bloc/PeriodBloc/period_bloc.dart';
import 'Bloc/ProfileBloc/profile_bloc.dart';
import 'Bloc/ProfileSettingBloc/setting_bloc.dart';
import 'Network/Repository/repository.dart';
import 'Utilites/GlobalWidgets/Texts/language_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Foregorn:$message");
  await Firebase.initializeApp();
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await LanguageController.load('english');

  final lan = await SharedPref.getLanguage();
  // await LanguageController.load(lan);
  print("Get Language ::::$lan");


  final repository = Repository();
  final bio = BiometricService();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await NotificationService.init();

  // final notificationService=NotificationService();
  // await notificationService.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<OnboardingBloc>(create: (context) => OnboardingBloc()),
        BlocProvider<PeriodBloc>(create: (context) => PeriodBloc()),
        BlocProvider<BottomNavigationBloc>(
          create: (context) => BottomNavigationBloc(),
        ),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(repository,bio)),
        BlocProvider<CategorieBloc>(create: (context) => CategorieBloc(repository,)),
        BlocProvider<ExpenseBloc>(create: (context) => ExpenseBloc(repository,)),
        BlocProvider<NotificationBloc>(create: (context) => NotificationBloc(repository,)),
        BlocProvider<SettingBloc>(create: (context) => SettingBloc()),
        BlocProvider<ProfileBloc>(create: (context) => ProfileBloc(authBloc: context.read<AuthBloc>(),)),
        BlocProvider<LanguageBloc>(
          create: (context) => LanguageBloc()..add(LoadLanguageEvent()),
        ),      ],
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
  builder: (context, state) {
    return MaterialApp.router(
      routerConfig: appRoute,
      debugShowCheckedModeBanner: false,

      locale: Locale(state.currentLang),

      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('gu'),
      ],

      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
    );
  },
);
  }
}
