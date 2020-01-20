import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/core/bloc/bloc.dart';
import 'package:reminder/features/calendar/presentation/bloc/bloc.dart';
import 'package:reminder/features/prescriptions/domain/entities/f_pill_entity.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../dependency_injector.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({Key key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
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

  Widget _buildPage(BuildContext context) {
    return TableCalendar(
      availableCalendarFormats: {CalendarFormat.month: "month"},
      calendarController: _calendarController,
    );
  }

  void _buildMonthlyEvents(List<FPPillEntity> prescriptionsEvents) {}

  void _initialCalendarState(BuildContext context) {
    final appState = BlocProvider.of<AppBloc>(context).state;
    if (appState is AppLoggedState) {
      final String uid = appState.user.uid;
      BlocProvider.of<CalendarBloc>(context)
          .add(FCalendarAllPillEvent(uid: uid));
    }
  }

  BlocBuilder _blocBuilder(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (BuildContext context, CalendarState state) {
        // TODO Uncomment
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
        if (state is FCalendarAllPillState) {
          print("InitialCalendarState");
          final appState = BlocProvider.of<AppBloc>(context).state;
          if (appState is AppLoggedState) {
            final now = DateTime.now();
            final today = "${now.year}-${now.month}-${now.day}";

            BlocProvider.of<CalendarBloc>(context).add(
              FCalendarDayPillHistoryEvent(
                date: today,
                uid: appState.user.uid,
              ),
            );
          }
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
