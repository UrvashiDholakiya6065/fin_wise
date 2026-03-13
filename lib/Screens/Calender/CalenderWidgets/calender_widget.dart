import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({super.key});

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      rowHeight: 40,
      firstDay: DateTime(2000),
      lastDay: DateTime(2100),
      focusedDay: focusedDay,

      selectedDayPredicate: (day) {
        return isSameDay(selectedDay, day);
      },
      startingDayOfWeek: StartingDayOfWeek.monday,

      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          this.selectedDay = selectedDay;
          this.focusedDay = focusedDay;
        });
      },

      calendarStyle: CalendarStyle(

        todayDecoration: BoxDecoration(
          border: Border.all(
            color: ColorsWidgets.mainAppColor,
            width: 2,
          ),
          shape: BoxShape.circle,
        ),
        selectedTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),

        selectedDecoration: BoxDecoration(
          color: ColorsWidgets.mainAppColor,
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(
          color: ColorsWidgets.mainAppColor,
          fontWeight: FontWeight.bold,
        ),


      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          color: ColorsWidgets.blue,
          fontWeight: FontWeight.w600,
        ),
        weekendStyle: TextStyle(
          color: ColorsWidgets.blue,
          fontWeight: FontWeight.w600,
        ),
      ),

      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          color: ColorsWidgets.mainAppColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        leftChevronIcon:
        Icon(Icons.chevron_left, color: ColorsWidgets.mainAppColor),
        rightChevronIcon:
        Icon(Icons.chevron_right, color: ColorsWidgets.mainAppColor),
      ),
    );
  }
}