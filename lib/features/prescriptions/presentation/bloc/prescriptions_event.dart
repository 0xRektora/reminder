import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/f_pill_entity.dart';

abstract class PrescriptionsEvent extends Equatable {
  const PrescriptionsEvent();

  @override
  List<Object> get props => null;
}

class FPrescShowPillEvent extends PrescriptionsEvent {
  final String uid;
  final String pillName;

  FPrescShowPillEvent({@required this.uid, @required this.pillName});

  @override
  List<Object> get props => [uid, pillName];
}

class FPrescChangePillEvent extends PrescriptionsEvent {
  final FPPillEntity pillEntity;

  FPrescChangePillEvent({@required this.pillEntity});

  @override
  List<Object> get props => [pillEntity];
}

class FPrescDeletePillEvent extends PrescriptionsEvent {
  final String uid;
  final String pillName;

  FPrescDeletePillEvent({@required this.uid, @required this.pillName});

  @override
  List<Object> get props => [uid, pillName];
}

class FPrescListPillEvent extends PrescriptionsEvent {
  final String uid;

  FPrescListPillEvent({@required this.uid});
}

class FPrescDisplayAddPillEvent extends PrescriptionsEvent {}

class FPrescAddPillEvent extends PrescriptionsEvent {
  final FPPillEntity pillEntity;
  final String uid;

  FPrescAddPillEvent({@required this.pillEntity, @required this.uid});

  @override
  List<Object> get props => [pillEntity];
}
