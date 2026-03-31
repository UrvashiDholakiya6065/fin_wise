import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Bloc/PeriodBloc/period_bloc.dart';
import '../../../../Bloc/PeriodBloc/period_event.dart';
import '../../../../Bloc/PeriodBloc/period_state.dart';
import '../../../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import '../../../../Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import '../../../../Utilites/GlobalWidgets/Texts/language_controller.dart';

class PeriodSelectorWidget {
  Widget periodSelectorWidget(context) {
    List periods = [
      AppLocalizations.of(context)?.translate("Daily")??"Daily",
      AppLocalizations.of(context)?.translate("Weekly")??"Weekly",
      AppLocalizations.of(context)?.translate("Monthly")??"Monthly",
    ];

    return BlocBuilder<PeriodBloc, PeriodState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            height: 60,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: ColorsWidgets.lightGreenGrey,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: periods.map((period) {
                bool isSelected = state.selectedPeriod == period;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.read<PeriodBloc>().add(ChangePeriodEvent(period));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ColorsWidgets.mainAppColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        period,
                        style: FontsWidgets.poppins(
                          fontWeight: FontWeight.w400,
                          fontColor: ColorsWidgets.darkGreen,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
