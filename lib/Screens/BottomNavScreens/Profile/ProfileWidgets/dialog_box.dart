import 'package:fin_wise/Bloc/AuthBloc/auth_bloc.dart';
import 'package:fin_wise/Bloc/AuthBloc/auth_event.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../AppRoute/app_route.dart';
import '../../../../Utilites/GlobalWidgets/Texts/language_controller.dart';

class DialogBox {
  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          title: Text(
            AppLocalizations.of(context)?.translate("Logout Account") ??
                "Logout Account",
          ),

          content: Text(
            AppLocalizations.of(
                  context,
                )?.translate("Are you sure you want to logout account?") ??
                "Are you sure you want to logout account?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                appRoute.pop(context);
              },

              child: Text(
                AppLocalizations.of(context)?.translate("Cancel") ?? "Cancel",
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsWidgets.mainAppColor,
              ),
              onPressed: () {
                context.read<AuthBloc>().add(LogoutEvent());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalizations.of(
                            context,
                          )?.translate("Logout  Account Successfully") ??
                          "Logout  Account Successfully",
                    ),
                  ),
                );
              },

              child: Text(
                AppLocalizations.of(context)?.translate("Logout") ?? "Logout",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
