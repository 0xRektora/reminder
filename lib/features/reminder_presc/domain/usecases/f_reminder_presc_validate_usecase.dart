import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder/core/data/models/c_d_app_pill_model.dart';
import 'package:reminder/core/error/failures.dart';
import 'package:reminder/core/usecases/usecase.dart';
import 'package:reminder/features/prescriptions/domain/entities/f_pill_entity.dart';
import 'package:reminder/features/reminder_schedule/domain/repositories/f_reminder_schedule_repo.dart';

class FReminderPrescValidateUsecase
    extends Usecase<bool, FReminderPrescValidateUsecaseParam> {
  final FReminderScheduleRepo fReminderScheduleRepo;

  FReminderPrescValidateUsecase({@required this.fReminderScheduleRepo});

  @override
  Future<Either<Failure, bool>> call(
      FReminderPrescValidateUsecaseParam params) async {
    try {
      final CDAppPillModel cdAppPillModel = CDAppPillModel(
        current: params.fpPillEntity.current,
        pillName: params.fpPillEntity.pillName,
        qtyToTake: params.fpPillEntity.qtyToTake,
        remindAt: params.fpPillEntity.remindAt,
        remindWhen: params.fpPillEntity.remindWhen,
        taken: params.fpPillEntity.taken,
        total: params.fpPillEntity.total,
      );
      return await fReminderScheduleRepo.validate(
        uid: params.uid,
        cdAppPillModel: cdAppPillModel,
        flutterLocalNotificationsPlugin: params.flutterLocalNotificationsPlugin,
      );
    } on InternalFailure catch (e) {
      return Left(InternalFailure(message: e.message));
    }
  }
}

class FReminderPrescValidateUsecaseParam extends Equatable {
  final String uid;
  final FPPillEntity fpPillEntity;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  FReminderPrescValidateUsecaseParam({
    @required this.uid,
    @required this.fpPillEntity,
    @required this.flutterLocalNotificationsPlugin,
  });

  @override
  List<Object> get props => [
        uid,
        fpPillEntity,
        flutterLocalNotificationsPlugin,
      ];
}
