import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:reminder/features/prescriptions/domain/entities/f_pill_entity.dart';

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
  List<Object> get props => [pillEntity];
}
