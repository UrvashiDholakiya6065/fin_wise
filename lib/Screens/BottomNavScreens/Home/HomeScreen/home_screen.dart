import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/AppRoute/app_route_path.dart';
import 'package:fin_wise/Bloc/AuthBloc/auth_state.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/ThemeHelper/time_greeting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Bloc/AuthBloc/auth_bloc.dart';
import '../../../../Bloc/AuthBloc/auth_event.dart';
import '../../../../Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
import '../HomeWidgets/balance_summery_Widget.dart';
import '../HomeWidgets/period_selector_widget.dart';
import '../HomeWidgets/savings_goals_widget.dart';
import '../HomeWidgets/transaction_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthBloc>().add(FetchUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final userName = state.userModel?.fullName??"Welcome Back";
            return CommonAppbar().commonAppBar(
              title: "Hi, $userName",
              subtitle: TimeGreeting().getGreeting(),
            );
          },
        ),
      ),
      body: CommonAppUi(
        topWidget: BalanceSummeryWidget().balanceSummaryWidget(),
        bottomWidget: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            // final userName = state.userModel?.fullName;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 18),
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          appRoute.push(AppRoutePath.quicklyAnalysisScreen
                              .path);
                        },
                        child: SavingsGoalsWidget().savingsGoalsWidget()),
                    SizedBox(height: 24),
                    PeriodSelectorWidget().periodSelectorWidget(),
                    SizedBox(height: 18),

                    ListView.builder(
                      itemCount: transactions.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = transactions[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: TransactionItemWidget().transactionItemWidget(
                            icon: item["icon"],
                            title: item["title"],
                            timeDate: item["timeDate"],
                            category: item["category"],
                            amount: item["amount"],
                            isExpense: item["isExpense"],
                            context: context,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        bottomSize: 4,
      ),
    );
  }
}
