import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/Bloc/AuthBloc/auth_bloc.dart';
import 'package:fin_wise/Bloc/CategorieBloc/categorie_bloc.dart';
import 'package:fin_wise/Bloc/ExpenseBloc/expense_bloc.dart';
import 'package:fin_wise/Bloc/OnboardingBloc/onboarding_bloc.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/BiomatricService/biomatric_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/BottomNavBloc/bottom_nav_bloc.dart';
import 'Bloc/PeriodBloc/period_bloc.dart';
import 'Network/Repository/repository.dart';
import 'Screens/Splash/splash_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();


  final repository = Repository();
  final bio = BiometricService();
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
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRoute,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.white)),
    );
  }
}
