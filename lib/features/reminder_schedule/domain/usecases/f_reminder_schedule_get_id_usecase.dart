import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder/core/error/failures.dart';
import 'package:reminder/core/usecases/usecase.dart';
import 'package:reminder/features/reminder_schedule/domain/repositories/f_reminder_schedule_repo.dart';

class FReminderScheduleGetIdUsecase
    implements Usecase<int, FReminderScheduleGetIdParam> {
  final FReminderScheduleRepo reminderScheduleRepo;

  FReminderScheduleGetIdUsecase({@required this.reminderScheduleRepo});

  @override
  Future<Either<Failure, int>> call(FReminderScheduleGetIdParam params) async {
    return await reminderScheduleRepo.getId(name: params.name);
  }
}

class FReminderScheduleGetIdParam extends Equatable {
  final String name;

  FReminderScheduleGetIdParam({
    @required this.name,
  });

  @override
  List<Object> get props => [name];
}
