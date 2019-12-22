import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reminder/core/usecases/c_app_delete_pill_usecase.dart';
import 'package:reminder/core/usecases/usecase.dart';

import './bloc.dart';
import '../../../../core/usecases/c_app_add_pill_usecase.dart';
import '../../../../core/usecases/c_app_all_pill_usecase.dart';
import '../../../../core/usecases/c_app_get_pill_usecase.dart';

class PrescriptionsBloc extends Bloc<PrescriptionsEvent, PrescriptionsState> {
  final CAppAddPillUsecase cAppAddPillUsecase;
  final CAppAllPillUsecase cAppAllPillUsecase;
  final CAppGetPillUsecase cAppGetPillUsecase;
  final CAppDeletePillUsecase cAppDeletePillUsecase;

  PrescriptionsBloc({
    @required this.cAppAddPillUsecase,
    @required this.cAppAllPillUsecase,
    @required this.cAppGetPillUsecase,
    @required this.cAppDeletePillUsecase,
  });

  @override
  PrescriptionsState get initialState => InitialPrescriptionsState();

  @override
  Stream<PrescriptionsState> mapEventToState(
    PrescriptionsEvent event,
  ) async* {
    if (event is FPrescListPillEvent) {
      print("ListPillsEvent");
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

    if (event is FPrescDeletePillEvent) {
      print("DeletePillEvent");
      final usecase = await cAppDeletePillUsecase(
        CAppDeletePillParam(
          pillName: event.pillName,
          uid: event.uid,
        ),
      );

      yield* usecase.fold(
        (failure) async* {
          print("Error:${failure.message}");
        },
        (result) async* {
          yield FPrescDeletePillState(uid: event.uid);
        },
      );
    }

    if (event is FPrescAddPillEvent) {
      print("AddPillEvent");
      final usecase = await cAppAddPillUsecase(
        CAppAddPillParams(
          fpPillEntity: event.pillEntity,
          uid: event.uid,
        ),
      );
      yield* usecase.fold(
        (failure) async* {
          print("Error:${failure.message}");
        },
        (success) async* {
          print("Success:${success}");
          yield FPrescAddPillState(uid: event.uid);
        },
      );
    }
  }
}
