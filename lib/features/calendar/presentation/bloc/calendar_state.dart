import 'package:equatable/equatable.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();
}

class InitialCalendarState extends CalendarState {
  @override
  List<Object> get props => [];
}
