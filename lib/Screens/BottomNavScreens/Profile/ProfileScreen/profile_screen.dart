import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/AppRoute/app_route_path.dart';
import 'package:fin_wise/Bloc/AuthBloc/auth_state.dart';
import 'package:fin_wise/Screens/BottomNavScreens/Profile/ProfileWidgets/dialog_box.dart';
import 'package:fin_wise/Screens/BottomNavScreens/Profile/ProfileWidgets/profile_widgets.dart';
import 'package:fin_wise/SessionManage/shared_pref.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Bloc/AuthBloc/auth_bloc.dart';
import '../../../../Bloc/AuthBloc/auth_event.dart';
import '../../../../Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import '../../../../Utilites/GlobalWidgets/PngImages/images_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthBloc>().add(FetchUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar().commonAppBar(
        centerTitle: true,
        // backArrow: true,
        title: TextsWidgets.profile,
      ),

      body: CommonAppUi(
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
                  final user=state.userModel;
                  return Column(
                    children: [
                      Text(
                        user?.fullName??"User",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),

                      Text(
                        user?.email??"User@gmail.com",
                        style: TextStyle(color: Colors.grey),
                      ),

                      SizedBox(height: 35),

                      GestureDetector(
                        onTap: (){
                          appRoute.push(AppRoutePath.editProfileScreen.path);
                        },
                        child: ProfileWidgets().profileTile(
                          ImagesWidget.profileIconImg,
                          "Edit Profile",
                        ),
                      ),
                      ProfileWidgets().profileTile(
                        ImagesWidget.profileScreenSecuirityImg,
                        "Security",
                      ),
                      GestureDetector(
                        onTap: (){
                          appRoute.push(AppRoutePath.settingScreen.path);
                        },
                        child: ProfileWidgets().profileTile(
                          ImagesWidget.profileScreenSettingImg,
                          "Setting",
                        ),
                      ),
                      ProfileWidgets().profileTile(
                        ImagesWidget.profileScreenHelpImg,
                        "Help",
                      ),

                      GestureDetector(
                        onTap: () {
                          DialogBox().showDeleteDialog(context);
                          // SharedPref.logout();
                        },
                        child: ProfileWidgets().profileTile(
                          ImagesWidget.profileScreenLogoutImg,
                          "Logout",
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        bottomSize: 14,
      ),
    );
  }
}
