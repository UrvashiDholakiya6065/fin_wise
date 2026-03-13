import 'package:carousel_slider/carousel_slider.dart';
import 'package:fin_wise/SessionManage/shared_pref.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../AppRoute/app_route.dart';
import '../../AppRoute/app_route_path.dart';
import '../../Bloc/OnboardingBloc/onboarding_bloc.dart';
import '../../Bloc/OnboardingBloc/onboarding_event.dart';
import '../../Bloc/OnboardingBloc/onboarding_state.dart';
import '../../Utilites/GlobalWidgets/Buttons/ElevatedButton/elevated_buttons.dart';
import '../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import '../../Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import '../../Utilites/GlobalWidgets/PngImages/images_widget.dart';
import '../../Utilites/GlobalWidgets/Texts/texts_widgets.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final CarouselSliderController controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              CarouselSlider(
                carouselController: controller,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    context.read<OnboardingBloc>().add(ChangeIndexEvent(index));
                  },
                ),
                items: [
                  CommonAppUi(
                    topWidget: Text(
                      TextsWidgets.onBoardingWelcome1,
                      textAlign: TextAlign.center,
                      style: FontsWidgets.poppins(
                        fontColor: ColorsWidgets.darkGreen,
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                      ),
                    ),
                    bottomWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: ColorsWidgets.lightGreen,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            ImagesWidget.onboardingImage1,
                            height: 180,
                          ),
                        ),
                        SizedBox(height: 40),
                        ElevatedButtons.elevatedButton(
                          text: TextsWidgets.getStarted,
                          onTap: () {
                            SharedPref.setOnboarding(true);
                            controller.nextPage();
                          },
                          textColor: ColorsWidgets.white,
                          backgroundColor: ColorsWidgets.mainAppColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ],
                    ),
                    bottomSize: 3,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CommonAppUi(
                      topWidget: Text(
                        TextsWidgets.onBoardingWelcome2,
                        textAlign: TextAlign.center,
                        style: FontsWidgets.poppins(
                          fontColor: ColorsWidgets.darkGreen,
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                        ),
                      ),
                      bottomWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorsWidgets.lightGreen,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              ImagesWidget.onboardingImage2,
                              height: 180,
                            ),
                          ),
                          SizedBox(height: 40),
                          ElevatedButtons.elevatedButton(
                            text: TextsWidgets.letsStart,
                            onTap: () {
                              appRoute.go(AppRoutePath.launchScreen.path);
                            },
                            textColor: ColorsWidgets.white,
                            backgroundColor: ColorsWidgets.mainAppColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ],
                      ),
                      bottomSize: 3,
                    ),
                  ),
                ],
              ),

              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    2,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: state.index == index ? 12 : 12,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: state.index == index
                            ? ColorsWidgets.mainAppColor
                            : Colors.transparent,
                        border: Border.all(
                          color: state.index==index?ColorsWidgets.mainAppColor:ColorsWidgets.black,
                          width: 2,
                        ),
                        // borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
