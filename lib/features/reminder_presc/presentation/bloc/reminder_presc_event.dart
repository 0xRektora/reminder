import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ReminderPrescEvent extends Equatable {
  const ReminderPrescEvent();

  @override
  List<Object> get props => [];
}

class FReminderPrescValidateEvent extends ReminderPrescEvent {
  final String uid;
  final String pillName;

  FReminderPrescValidateEvent({
    @required this.uid,
    @required this.pillName,
  });

  @override
  List<Object> get props => [
        uid,
        pillName,
      ];
}

class FReminderPrescListEvent extends ReminderPrescEvent {
  final String uid;

  FReminderPrescListEvent({@required this.uid});
}
