import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../prescriptions/domain/entities/f_pill_entity.dart';
import '../../domain/entities/f_c_pill_history_entity.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => [];
}

class InitialCalendarState extends CalendarState {}

class FCalendarAllPillState extends CalendarState {
  final List<FPPillEntity> pillEntity;

  FCalendarAllPillState({@required this.pillEntity});

  @override
  List<Object> get props => [
        pillEntity,
      ];
}

class FCalendarDayPillHistoryState extends CalendarState {
  final List<FCPillHistoryEntity> listPillHistory;

  FCalendarDayPillHistoryState({
    @required this.listPillHistory,
  });

  @override
  List<Object> get props => [
        listPillHistory,
      ];
}

class FCalendarMonthPillHistoryState extends CalendarState {
  final Map<String, List<FCPillHistoryEntity>> listPillHistory;

  FCalendarMonthPillHistoryState({
    @required this.listPillHistory,
  });

  @override
  List<Object> get props => [
        listPillHistory,
      ];
}
