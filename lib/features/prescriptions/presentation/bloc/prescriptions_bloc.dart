import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PrescriptionsBloc extends Bloc<PrescriptionsEvent, PrescriptionsState> {
  @override
  PrescriptionsState get initialState => InitialPrescriptionsState();

  @override
  Stream<PrescriptionsState> mapEventToState(
    PrescriptionsEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
