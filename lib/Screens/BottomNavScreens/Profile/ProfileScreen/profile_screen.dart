import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/AppRoute/app_route_path.dart';
import 'package:fin_wise/Bloc/AuthBloc/auth_state.dart';
import 'package:fin_wise/Bloc/LanguageBloc/language_bloc.dart';
import 'package:fin_wise/Bloc/LanguageBloc/language_state.dart';
import 'package:fin_wise/Screens/BottomNavScreens/Profile/ProfileWidgets/dialog_box.dart';
import 'package:fin_wise/Screens/BottomNavScreens/Profile/ProfileWidgets/profile_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Bloc/AuthBloc/auth_bloc.dart';
import '../../../../Bloc/AuthBloc/auth_event.dart';
import '../../../../Bloc/LanguageBloc/language_event.dart';
import '../../../../Network/TranslateRepo/transalre_repo.dart';
import '../../../../Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import '../../../../Utilites/GlobalWidgets/PngImages/images_widget.dart';
import '../../../../Utilites/GlobalWidgets/Texts/language_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String translatedName = "";
  String lastName = "";

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(FetchUserEvent());
  }

  Future<void> translateName(String name) async {
    if (name.isEmpty || name == lastName) return;

    lastName = name;

    final lang = context.read<LanguageBloc>().state.currentLang;

    if (lang == 'en') {
      setState(() {
        translatedName = name;
      });
      return;
    }

    final result = await TranslationService.translate(name, lang);

    setState(() {
      translatedName = result;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar().commonAppBar(
        centerTitle: true,
        // backArrow: true,

          title:           AppLocalizations.of(context)?.translate("profile")??"profile",

      ),

      body: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return CommonAppUi(
            bottomWidget: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -45,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(ImagesWidget.profileScreenImg),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 25, right: 25),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final user = state.userModel;
                      final userName = user?.fullName ?? "User";

                      translateName(userName);

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              translatedName,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),

                            Text(
                              user?.email ?? "User@gmail.com",
                              style: TextStyle(color: Colors.grey),
                            ),

                            SizedBox(height: 35),

                            GestureDetector(
                              onTap: () {
                                appRoute.push(
                                    AppRoutePath.editProfileScreen.path);
                              },
                              child: ProfileWidgets().profileTile(
                                ImagesWidget.profileIconImg,
                                AppLocalizations.of(context)?.translate( "Edit Profile")?? "Edit Profile"
                               ,
                              ),
                            ),
                            ProfileWidgets().profileTile(
                              ImagesWidget.profileScreenSecuirityImg,
                              AppLocalizations.of(context)?.translate("Security")?? "Security"
                            ),
                            GestureDetector(
                              onTap: () {
                                appRoute.push(AppRoutePath.settingScreen.path);
                              },
                              child: ProfileWidgets().profileTile(
                                ImagesWidget.profileScreenSettingImg,
                                AppLocalizations.of(context)?.translate("Setting")?? "Setting"

                              ),
                            ),
                            ProfileWidgets().profileTile(
                              ImagesWidget.profileScreenHelpImg,
                              AppLocalizations.of(context)?.translate("Help")?? "Help"
                            ),

                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<LanguageBloc>().add(
                                        ChangeLanguageEvent('en'));
                                  },
                                  child: Text("English"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<LanguageBloc>().add(
                                        ChangeLanguageEvent('hi'));
                                  },
                                  child: Text("हिन्दी"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<LanguageBloc>().add(
                                        ChangeLanguageEvent('gu'));
                                  },
                                  child: Text("ગુજરાતી"),
                                ),
                              ],
                            ),

                            GestureDetector(
                              onTap: () {
                                DialogBox().showDeleteDialog(context);
                                // SharedPref.logout();
                              },
                              child: ProfileWidgets().profileTile(
                                ImagesWidget.profileScreenLogoutImg,
                                AppLocalizations.of(context)?.translate("Logout")?? "Logout"
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            bottomSize: 14,
          );
        },
      ),
    );
  }
}
