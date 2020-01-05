import 'package:equatable/equatable.dart';

abstract class ReminderPrescState extends Equatable {
  const ReminderPrescState();
}

class InitialReminderPrescState extends ReminderPrescState {
  @override
  List<Object> get props => [];
}
