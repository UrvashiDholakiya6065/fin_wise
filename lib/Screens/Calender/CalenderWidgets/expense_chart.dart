import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CalendarPieChart extends StatelessWidget {
  const CalendarPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    startDegreeOffset: 280,
                    centerSpaceRadius: 0,
                    sectionsSpace: 2,
                    borderData: FlBorderData(show: false),

                    sections: [
                      PieChartSectionData(
                        value: 79,
                        color:  ColorsWidgets.lightBlue,
                        radius: 100,
                        title: "79%",
                        showTitle: true,

                        titlePositionPercentageOffset: 0.45,
                        titleStyle:  TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),

                      ),
                      // PieChartSectionData(
                      //   value: 80,
                      //   color: ColorsWidgets.lightBlue,
                      //   radius: 100,
                      //   showTitle: false,
                      //   titlePositionPercentageOffset: -0.5,
                      // ),
                      PieChartSectionData(
                        value: 10,
                        color: ColorsWidgets.blue,
                        radius: 100,
                        title: "10%",
                        titlePositionPercentageOffset: 0.65,
                        titleStyle: FontsWidgets.poppins(
                          fontColor: ColorsWidgets.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        // borderSide:
                        // const BorderSide(color: Colors.white, width: 2),
                      ),

                      PieChartSectionData(
                        value: 11,
                        color:  ColorsWidgets.skyBlue,
                        radius: 100,
                        title: "11%",
                        titlePositionPercentageOffset: 0.6,
                        titleStyle: FontsWidgets.poppins(
                          fontColor: ColorsWidgets.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        // borderSide:
                        // const BorderSide(color: Colors.white, width: 2),
                      ),
                    ],
                  ),
                ),
              ),

              // Positioned(
              //   top: 44,
              //   right: 110,
              //   child: Text(
              //     "79%",
              //     style: FontsWidgets.poppins(
              //       fontColor: ColorsWidgets.white,
              //       fontWeight: FontWeight.w600,
              //       fontSize: 14,
              //     ),
              //   ),
              // ),



        // SizedBox(
        //   width: double.infinity,
        //   child: Stack(
        //     alignment: Alignment.topCenter,
        //     children: [
        //
        //       SizedBox(
        //         height: 100,
        //         child: ClipRect(
        //           child: Align(
        //             alignment: Alignment.bottomCenter,
        //             heightFactor: 0.30,
        //             child: SizedBox(
        //               height: 2,
        //               child: PieChart(
        //                 PieChartData(
        //                   startDegreeOffset: 280,
        //                   centerSpaceRadius: 0,
        //                   sectionsSpace: 1,
        //                   borderData: FlBorderData(show: false),
        //                   sections: [
        //                     PieChartSectionData(
        //                       value: 80,
        //                       color: Color(0xff4F86C6),
        //                       radius: 100,
        //                       showTitle: false,
        //                     ),
        //                     PieChartSectionData(
        //                       value: 17,
        //                       color: Color(0xffA9C6EC),
        //                       radius: 100,
        //                       title: "11%",
        //                     ),
        //                     PieChartSectionData(
        //                       value: 14,
        //                       color: Color(0xff1E63D0),
        //                       radius: 100,
        //                       title: "10%",
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //
        //   Positioned(
        //     top: 34,
        //     right: 120,
        //     child: Text(
        //       "79%",
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontSize: 16,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   )
        //
        //     ],
        //   ),
        // ),
        SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Icon(Icons.circle, size: 10, color: ColorsWidgets.blue),
            SizedBox(width: 6),
            Text("Groceries"),

            SizedBox(width: 30),

            Icon(Icons.circle, size: 10, color:  ColorsWidgets.lightBlue),
            SizedBox(width: 6),
            Text("Others"),
          ],
        ),
      ],
    );
  }
}
