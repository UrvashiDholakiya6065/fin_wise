import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/AppRoute/app_route_path.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/PngImages/images_widget.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/language_controller.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';

class BarChartSample2 extends StatefulWidget {
  BarChartSample2({super.key});
  final Color leftBarColor = ColorsWidgets.mainAppColor;
  final Color rightBarColor = ColorsWidgets.blue;
  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    // final barGroup5 = makeGroupData(4, 17, 6);
    // final barGroup6 = makeGroupData(5, 19, 1.5);
    // final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      // barGroup5,
      // barGroup6,
      // barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsWidgets.lightGreen,
        borderRadius: BorderRadius.circular(50)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[

                Text( AppLocalizations.of(context)?.translate("quicklyAnalysisScreenChartAprilExpenses")??"quicklyAnalysisScreenChartAprilExpenses",
          style: FontsWidgets.poppins(
                  fontColor: ColorsWidgets.darkGreen,
                  fontWeight: FontWeight.w500
                ),),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    appRoute.push(AppRoutePath.searchScreen.path);
                  },
                  child: Container(height: 30,
                  width: 32,
                  decoration: BoxDecoration(
                    color: ColorsWidgets.mainAppColor,
                    borderRadius: BorderRadius.circular(12)
                  ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(ImagesWidget.quicklyAnalysisSearchImg,height: 16,),
                    ),
                  ),
                ),
                SizedBox(width: 4,),
                GestureDetector(
                  onTap: (){
                    appRoute.push(AppRoutePath.calenderScreen.path);
                  },
                  child: Container(height: 30,
                    width: 32,
                    decoration: BoxDecoration(
                        color: ColorsWidgets.mainAppColor,
                        borderRadius: BorderRadius.circular(12)
                    ),
                  
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(ImagesWidget.quicklyAnalysisCalenderImg,height: 16,),
                    ),
                  ),
                )
                // makeTransactionsIcon(),

              ],
            ),
               SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(

                  maxY: 40,
                  groupsSpace: 20,

                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: ((group) {
                        return Colors.grey;
                      }),
                      getTooltipItem: (a, b, c, d) => null,
                    ),
                    touchCallback: (FlTouchEvent event, response) {
                      if (response == null || response.spot == null) {
                        setState(() {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                        });
                        return;
                      }

                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                      setState(() {
                        if (!event.isInterestedForInteractions) {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                          return;
                        }
                        showingBarGroups = List.of(rawBarGroups);
                        if (touchedGroupIndex != -1) {
                          var sum = 0.0;
                          for (final rod
                          in showingBarGroups[touchedGroupIndex].barRods) {
                            sum += rod.toY;
                          }
                          final avg = sum /
                              showingBarGroups[touchedGroupIndex]
                                  .barRods
                                  .length;

                          showingBarGroups[touchedGroupIndex] =
                              showingBarGroups[touchedGroupIndex].copyWith(
                                barRods: showingBarGroups[touchedGroupIndex]
                                    .barRods
                                    .map((rod) {
                                  return rod.copyWith(
                                      toY: avg, color:Colors.blue);
                                }).toList(),
                              );
                        }
                      });
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 30,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),

                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      bottom: BorderSide(
                        color: ColorsWidgets.black,
                        width: 1,
                      ),

                    ),


                  ),
                  barGroups: showingBarGroups,
                  gridData:  FlGridData(show: false),
                ),
              ),
            ),
             SizedBox(
              height: 10,
            ),


          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    TextStyle style = FontsWidgets.leagueSpartan(
      fontColor: ColorsWidgets.blue,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 20) {
      text = '10K';
    } else if (value == 30) {
      text = '15K';}else {
      return Container();
    }
    return SideTitleWidget(
      meta: meta,
      space:0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = ['1st Week', '2nd Week', '3rd Week', '4th Week'];

    if (value.toInt() >= titles.length) {
      return Container();
    }

    return SideTitleWidget(
      meta: meta,
      space: 10,
      child: Text(
        titles[value.toInt()],
        textAlign: TextAlign.center,
        style:  FontsWidgets.leagueSpartan(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          fontColor: ColorsWidgets.darkGreen
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 10,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }


}