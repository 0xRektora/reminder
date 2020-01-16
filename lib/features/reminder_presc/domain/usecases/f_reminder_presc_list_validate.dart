import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/f_reminder_presc_presc_notification_entity.dart';
import '../repositories/f_reminder_presc_repo.dart';

class FReminderPrescListValidateUsecase extends Usecase<
    List<FReminderPrescPrescNotificationEntity>,
    FReminderPrescListValidateUsecaseParam> {
  final FReminderPrescRepo fReminderPrescRepo;

  FReminderPrescListValidateUsecase({@required this.fReminderPrescRepo});

  @override
  Future<Either<Failure, List<FReminderPrescPrescNotificationEntity>>> call(
      FReminderPrescListValidateUsecaseParam params) async {
    return fReminderPrescRepo.listValidate(uid: params.uid);
  }
}

class FReminderPrescListValidateUsecaseParam extends Equatable {
  final String uid;

  FReminderPrescListValidateUsecaseParam({@required this.uid});

  @override
  List<Object> get props => [uid];
}
