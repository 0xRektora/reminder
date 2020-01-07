import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../../core/data/models/c_d_app_pill_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../prescriptions/domain/entities/f_pill_entity.dart';
import '../../../reminder_schedule/domain/repositories/f_reminder_schedule_repo.dart';

class FReminderPrescValidateUsecase
    extends Usecase<bool, FReminderPrescValidateUsecaseParam> {
  final FReminderScheduleRepo fReminderScheduleRepo;

  FReminderPrescValidateUsecase({@required this.fReminderScheduleRepo});

  @override
  Future<Either<Failure, bool>> call(
      FReminderPrescValidateUsecaseParam params) async {
    try {
      return await fReminderScheduleRepo.validate(
        uid: params.uid,
        fpPillEntity: params.fpPillEntity,
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
