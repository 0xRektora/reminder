import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../../../dependency_injector.dart';
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
      final usecase = await fReminderPrescListValidateUsecase(
        FReminderPrescListValidateUsecaseParam(
          uid: event.uid,
        ),
      );

      yield* usecase.fold(
        (failure) async* {
          print("Failure FReminderPrescListEvent: " + failure.message);
        },
        (success) async* {
          print("Success FReminderPrescListEvent");
          yield FReminderPrescListState(prescNotificationEntity: success);
        },
      );
    }

    if (event is FReminderPrescValidateEvent) {
      final usecase = await fReminderPrescValidateUsecase(
        FReminderPrescValidateUsecaseParam(
          flutterLocalNotificationsPlugin: sl(),
          pillName: event.pillName,
          uid: event.uid,
        ),
      );

      yield* usecase.fold(
        (failure) async* {
          print("Failure FReminderPrescValidateEvent: " + failure.message);
        },
        (success) async* {
          print("Success FReminderPrescValidateEvent");
          yield FReminderPrescValidateState(uid: event.uid);
        },
      );
    }
  }
}
