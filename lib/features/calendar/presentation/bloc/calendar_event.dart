import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class FCalendarAllPillEvent extends CalendarEvent {
  final String uid;

  FCalendarAllPillEvent({@required this.uid});

  @override
  List<Object> get props => [uid];
}
