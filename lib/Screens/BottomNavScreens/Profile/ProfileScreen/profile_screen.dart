import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/AppRoute/app_route_path.dart';
import 'package:fin_wise/Bloc/LanguageBloc/language_bloc.dart';
import 'package:fin_wise/Bloc/LanguageBloc/language_event.dart';
import 'package:fin_wise/Bloc/LanguageBloc/language_state.dart';
import 'package:fin_wise/Bloc/ProfileBloc/profile_bloc.dart';
import 'package:fin_wise/Bloc/ProfileBloc/profile_event.dart';
import 'package:fin_wise/Bloc/ProfileBloc/profile_state.dart';
import 'package:fin_wise/Screens/BottomNavScreens/Profile/ProfileWidgets/dialog_box.dart';
import 'package:fin_wise/Screens/BottomNavScreens/Profile/ProfileWidgets/profile_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Bloc/AuthBloc/auth_bloc.dart';
import '../../../../Bloc/AuthBloc/auth_event.dart';
import '../../../../Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import '../../../../Utilites/GlobalWidgets/Enum/enum.dart';
import '../../../../Utilites/GlobalWidgets/PngImages/images_widget.dart';
import '../../../../Utilites/GlobalWidgets/Texts/language_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();

    context.read<AuthBloc>().add(FetchUserEvent());

    final lang = context.read<LanguageBloc>().state.currentLang;
    context.read<ProfileBloc>().add(LoadProfileEvent(lang));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar().commonAppBar(
        centerTitle: true,
        title: AppLocalizations.of(context)?.translate("profile") ?? "profile",
      ),

      body: BlocListener<LanguageBloc, LanguageState>(
        listenWhen: (prev, curr) => prev.currentLang != curr.currentLang,
        listener: (context, langState) {

          context.read<ProfileBloc>().add(
            LoadProfileEvent(langState.currentLang),
          );
        },

        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {

            // if (state.profileStatus == ProfileStatus.loading) {
            //   return const Center(child: CircularProgressIndicator());
            // }

            if (state.profileStatus == ProfileStatus.error) {
              return const Center(child: Text("Error loading profile"));
            }

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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                          Text(
                            state.translatedName.isEmpty
                                ? state.userName
                                : state.translatedName,
                            style:  TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                           SizedBox(height: 4),

                          Text(
                            state.email,
                            style:  TextStyle(color: Colors.grey),
                          ),

                           SizedBox(height: 35),

                          GestureDetector(
                            onTap: () {
                              appRoute.push(AppRoutePath.editProfileScreen.path);
                            },
                            child: ProfileWidgets().profileTile(
                              ImagesWidget.profileIconImg,
                              AppLocalizations.of(context)
                                  ?.translate("Edit Profile") ??
                                  "Edit Profile",
                            ),
                          ),

                          ProfileWidgets().profileTile(
                            ImagesWidget.profileScreenSecuirityImg,
                            AppLocalizations.of(context)
                                ?.translate("Security") ??
                                "Security",
                          ),

                          GestureDetector(
                            onTap: () {
                              appRoute.push(AppRoutePath.settingScreen.path);
                            },
                            child: ProfileWidgets().profileTile(
                              ImagesWidget.profileScreenSettingImg,
                              AppLocalizations.of(context)
                                  ?.translate("Setting") ??
                                  "Setting",
                            ),
                          ),

                          ProfileWidgets().profileTile(
                            ImagesWidget.profileScreenHelpImg,
                            AppLocalizations.of(context)
                                ?.translate("Help") ??
                                "Help",
                          ),
                          ProfileWidgets().profileTile(
                            ImagesWidget.profileScreenHelpImg,
                            AppLocalizations.of(context)
                                ?.translate("ChatList") ??
                                "ChatList",
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  context.read<LanguageBloc>().add(
                                    ChangeLanguageEvent('en'),
                                  );
                                },
                                child:  Text("English"),
                              ),
                              SizedBox(width: 14,),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<LanguageBloc>().add(
                                    ChangeLanguageEvent('hi'),
                                  );
                                },
                                child:  Text("हिन्दी"),
                              ),
                              SizedBox(width: 14,),

                              ElevatedButton(
                                onPressed: () {
                                  context.read<LanguageBloc>().add(
                                    ChangeLanguageEvent('gu'),
                                  );
                                },
                                child:  Text("ગુજરાતી"),
                              ),
                            ],
                          ),
                          SizedBox(height: 14,),

                          GestureDetector(
                            onTap: () {
                              DialogBox().showDeleteDialog(context);
                            },
                            child: ProfileWidgets().profileTile(
                              ImagesWidget.profileScreenLogoutImg,
                              AppLocalizations.of(context)
                                  ?.translate("Logout") ??
                                  "Logout",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              bottomSize: 14,
            );
          },
        ),
      ),
    );
  }
}