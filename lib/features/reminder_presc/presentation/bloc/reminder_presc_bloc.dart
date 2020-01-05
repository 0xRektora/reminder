import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ReminderPrescBloc extends Bloc<ReminderPrescEvent, ReminderPrescState> {
  final 
  @override
  ReminderPrescState get initialState => InitialReminderPrescState();

  @override
  Stream<ReminderPrescState> mapEventToState(
    ReminderPrescEvent event,
  ) async* {
    if (event is FReminderPrescListEvent) {
      // TODO yield list state
    }
  }
}
