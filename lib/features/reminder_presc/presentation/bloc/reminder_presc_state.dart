import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/f_reminder_presc_presc_notification_entity.dart';

abstract class ReminderPrescState extends Equatable {
  const ReminderPrescState();
  @override
  List<Object> get props => [];
}

class InitialReminderPrescState extends ReminderPrescState {}

class FReminderPrescListState extends ReminderPrescState {
  final List<FReminderPrescPrescNotificationEntity> prescNotificationEntity;

  FReminderPrescListState({@required this.prescNotificationEntity});

  @override
  List<Object> get props => [prescNotificationEntity];
}
