import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../../../core/usecases/c_app_add_pill_usecase.dart';
import '../../../../core/usecases/c_app_all_pill_usecase.dart';
import '../../../../core/usecases/c_app_get_pill_usecase.dart';

class PrescriptionsBloc extends Bloc<PrescriptionsEvent, PrescriptionsState> {
  final CAppAddPillUsecase cAppAddPillUsecase;
  final CAppAllPillUsecase cAppAllPillUsecase;
  final CAppGetPillUsecase cAppGetPillUsecase;

  PrescriptionsBloc({
    @required this.cAppAddPillUsecase,
    @required this.cAppAllPillUsecase,
    @required this.cAppGetPillUsecase,
  });

  @override
  PrescriptionsState get initialState => InitialPrescriptionsState();

  @override
  Stream<PrescriptionsState> mapEventToState(
    PrescriptionsEvent event,
  ) async* {
    if (event is FPrescListPillEvent) {
      final listPills =
          await cAppAllPillUsecase(CAppGetAllPillParam(uid: event.uid));
      yield* listPills.fold(
        (failure) async* {
          yield InitialPrescriptionsState();
        },
        (allPills) async* {
          yield FPrescLoadingState();
          yield FprescListPillState(allPill: allPills);
        },
      );
    }

    if (event is FPrescShowPillEvent) {
      //TODO Add show pill event login
    }

    if (event is FPrescDisplayAddPillEvent) {
      yield FPrescDisplayAddPillState();
    }

    if (event is FPrescChangePillEvent) {
      //TODO Add change pill event login
    }

    if (event is FPrescAddPillEvent) {
      print("PillEvent");
      final usecase = await cAppAddPillUsecase(
          CAppAddPillParams(fpPillEntity: event.pillEntity, uid: event.uid));
      yield* usecase.fold((failure) async* {
        print("Error:${failure.message}");
      }, (success) async* {
        print("Success:${success}");
      });
    }
  }
}
