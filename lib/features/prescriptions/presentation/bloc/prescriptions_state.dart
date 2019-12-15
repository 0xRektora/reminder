import 'package:equatable/equatable.dart';

abstract class PrescriptionsState extends Equatable {
  const PrescriptionsState();
}

class InitialPrescriptionsState extends PrescriptionsState {
  @override
  List<Object> get props => [];
}
