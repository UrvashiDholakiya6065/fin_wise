import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/PngImages/images_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/BottomNavBloc/bottom_nav_bloc.dart';
import '../../../Bloc/BottomNavBloc/bottom_nav_event.dart';
import '../../../Bloc/BottomNavBloc/bottom_nav_state.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final Widget child;

  BottomNavigationBarWidget({super.key, required this.child});

  final List<String> routes = [
    '/HomeScreen',
    '/AnalysisScreen',
    '/TransactionScreen',
    '/CategoriesScreen',
    '/ProfileScreen',
  ];

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<BottomNavigationBloc, BottomNavState>(
      builder: (context, state) {

        return Scaffold(
          body: child,  
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: ColorsWidgets.lightGreen,
                borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset:  Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navIcon(context,ImagesWidget.homeImg,0,state),
                  _navIcon(context,ImagesWidget.analysisImg,1,state),
                  _navIcon(context,ImagesWidget.transactionsImg,2,state),
                  _navIcon(context,ImagesWidget.categoriesImg,3,state),
                  _navIcon(context,ImagesWidget.profileIconImg,4,state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _navIcon(
      BuildContext context,
      String icon,
      int index,
        BottomNavState state,
      ) {

    return GestureDetector(
      onTap: () {

        context.read<BottomNavigationBloc>()
            .add(ChangeTabEvent(index));

        appRoute.go(routes[index]);
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: state.currentIndex==index?ColorsWidgets.mainAppColor:Colors.transparent,
          borderRadius: BorderRadius.circular(22)
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            icon,
            color: state.currentIndex == index
                ? Colors.black
                : Colors.grey,
          ),
        ),
      ),
    );
  }
}