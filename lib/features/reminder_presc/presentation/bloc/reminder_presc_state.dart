import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:reminder/features/prescriptions/domain/entities/f_pill_entity.dart';

abstract class ReminderPrescState extends Equatable {
  const ReminderPrescState();
  @override
  List<Object> get props => [];
}

class InitialReminderPrescState extends ReminderPrescState {}

class FReminderPrescListState extends ReminderPrescState {
  final List<FPPillEntity> pillEnitityList;

  FReminderPrescListState({@required this.pillEnitityList});

  @override
  List<Object> get props => [pillEnitityList];
}
