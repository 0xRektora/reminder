import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  @override
  CalendarState get initialState => InitialCalendarState();

  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
