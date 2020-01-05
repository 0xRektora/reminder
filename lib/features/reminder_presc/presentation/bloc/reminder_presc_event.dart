import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:reminder/features/prescriptions/domain/entities/f_pill_entity.dart';

abstract class ReminderPrescEvent extends Equatable {
  const ReminderPrescEvent();

  @override
  List<Object> get props => [];
}

class FReminderPrescValidateEvent extends ReminderPrescEvent {
  final String uid;
  final FPPillEntity fpPillEntity;

  FReminderPrescValidateEvent({
    @required this.uid,
    @required this.fpPillEntity,
  });

  @override
  List<Object> get props => [
        uid,
        fpPillEntity,
      ];
}

class FReminderPrescListEvent extends ReminderPrescEvent {
  final String uid;

  FReminderPrescListEvent({@required this.uid});
}
