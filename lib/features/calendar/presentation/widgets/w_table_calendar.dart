import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class WTableCalendar extends StatefulWidget {
  const WTableCalendar({Key key}) : super(key: key);

  @override
  _WTableCalendarState createState() => _WTableCalendarState();
}

class _WTableCalendarState extends State<WTableCalendar> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TableCalendar(
        availableCalendarFormats: {CalendarFormat.month: ""},
        calendarController: _calendarController,
      ),
    );
  }
}
