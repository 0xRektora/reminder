import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../domain/usecases/f_reminder_presc_list_validate.dart';
import '../../domain/usecases/f_reminder_presc_validate_usecase.dart';

class ReminderPrescBloc extends Bloc<ReminderPrescEvent, ReminderPrescState> {
  final FReminderPrescListValidateUsecase fReminderPrescListValidateUsecase;
  final FReminderPrescValidateUsecase fReminderPrescValidateUsecase;

  ReminderPrescBloc({
    @required this.fReminderPrescListValidateUsecase,
    @required this.fReminderPrescValidateUsecase,
  });
  @override
  ReminderPrescState get initialState => InitialReminderPrescState();

  @override
  Stream<ReminderPrescState> mapEventToState(
    ReminderPrescEvent event,
  ) async* {
    if (event is FReminderPrescListEvent) {
      // TODO yield list state
    }

    if (event is FReminderPrescValidateEvent) {
      // TODO validate the entry
    }
  }
}
