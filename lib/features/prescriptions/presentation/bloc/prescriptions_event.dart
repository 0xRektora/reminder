import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/f_pill_entity.dart';

abstract class PrescriptionsEvent extends Equatable {
  const PrescriptionsEvent();

  @override
  List<Object> get props => null;
}

class FPrescShowPillEvent extends PrescriptionsEvent {}

class FPrescChangePillEvent extends PrescriptionsEvent {
  final FPPillEntity pillEntity;

  FPrescChangePillEvent({@required this.pillEntity});

  @override
  List<Object> get props => [pillEntity];
}

class FPrescListPillEvent extends PrescriptionsEvent {
  final String uid;

  FPrescListPillEvent({@required this.uid});
}

class FPrescDisplayAddPillEvent extends PrescriptionsEvent {}

class FPrescAddPillEvent extends PrescriptionsEvent {
  final FPPillEntity pillEntity;

  FPrescAddPillEvent({@required this.pillEntity});

  @override
  List<Object> get props => [pillEntity];
}
