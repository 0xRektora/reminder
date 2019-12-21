import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/f_pill_entity.dart';

abstract class PrescriptionsState extends Equatable {
  const PrescriptionsState();

  @override
  List<Object> get props => [];
}

class InitialPrescriptionsState extends PrescriptionsState {}

class FPrescLoadingState extends PrescriptionsState {}

class FprescListPillState extends PrescriptionsState {
  final List<FPPillEntity> allPill;

  FprescListPillState({@required this.allPill});

  @override
  List<Object> get props => [allPill];
}

class FPrescShowPillState extends PrescriptionsState {
  final FPPillEntity pillEntity;

  FPrescShowPillState({@required this.pillEntity});

  @override
  List<Object> get props => [pillEntity];
}

class FPrescAddPillState extends PrescriptionsState {
  final String uid;

  FPrescAddPillState({@required this.uid});

  @override
  List<Object> get props => [uid];
}

class FPrescDisplayAddPillState extends PrescriptionsState {}

class FPrescChangePillState extends PrescriptionsState {
  final FPPillEntity pillEntity;

  FPrescChangePillState({@required this.pillEntity});

  @override
  List<Object> get props => [pillEntity];
}
