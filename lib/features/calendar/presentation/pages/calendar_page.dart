import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/bloc/bloc.dart';
import '../../../../dependency_injector.dart';
import '../../domain/entities/f_c_pill_history_entity.dart';
import '../bloc/bloc.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({Key key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController _calendarController;
  Map<DateTime, List> pillEvents;

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

  Widget _dayBuilder(
    BuildContext context,
    DateTime dateTime,
    List<dynamic> events,
  ) {
    return Container(
      color: Colors.red,
      child: Text(dateTime.day.toString()),
    );
  }

  Widget _selectedDayBuilder(
    BuildContext context,
    DateTime dateTime,
    List<dynamic> events,
  ) {
    return Container(
      height: 5.0,
      width: 5.0,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(90.0),
      ),
      child: Center(
        child: Text(
          dateTime.day.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  CalendarBuilders _calendarBuilders() {
    return CalendarBuilders(
      // dayBuilder: _dayBuilder,
      selectedDayBuilder: _selectedDayBuilder,
    );
  }

  Widget _buildPage(BuildContext context) {
    return TableCalendar(
      availableCalendarFormats: {
        CalendarFormat.month: "month",
      },
      calendarController: _calendarController,
      events: pillEvents,
      builders: _calendarBuilders(),
    );
  }

  void _buildMonthlyEvents(
    List<FCPillHistoryEntity> prescriptionsEvents,
  ) {}

  void _initialCalendarState(BuildContext context) {
    final appState = BlocProvider.of<AppBloc>(context).state;
    if (appState is AppLoggedState) {
      final DateTime now = DateTime.now();

      final String uid = appState.user.uid;
      final int year = now.year;
      final int month = now.month;
      final String creationDate = appState.user.creationDate;

      final FCalendarMonthPillHistoryEvent monthPillHistoryEvent =
          FCalendarMonthPillHistoryEvent(
        uid: uid,
        year: year,
        month: month,
        creationDate: creationDate,
      );

      BlocProvider.of<CalendarBloc>(context).add(monthPillHistoryEvent);
    }
  }

  BlocBuilder _blocBuilder(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (BuildContext context, CalendarState state) {
        if (state is InitialCalendarState) _initialCalendarState(context);
        return _buildPage(context);
      },
    );
  }

  BlocListener _blocListener(
    BuildContext context,
    BlocBuilder Function(BuildContext context) blocBuilder,
  ) {
    return BlocListener<CalendarBloc, CalendarState>(
      listener: (BuildContext context, CalendarState state) {
        // TODO remove
        // test case
        if (state is InitialCalendarState) {}
        if (state is FCalendarMonthPillHistoryState) {
          print(state.listPillHistory);
        }
      },
      child: _blocBuilder(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalendarBloc>(
      create: (_) => sl(),
      child: _blocListener(context, _blocBuilder),
    );
  }
}
