import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder/core/error/failures.dart';
import 'package:reminder/core/usecases/usecase.dart';
import 'package:reminder/features/reminder_schedule/domain/repositories/f_reminder_schedule_repo.dart';

class FReminderScheduleSetUsecase
    implements Usecase<bool, FReminderScheduleSetUsecaseParam> {
  final FReminderScheduleRepo reminderScheduleRepo;

  FReminderScheduleSetUsecase({@required this.reminderScheduleRepo});

  @override
  Future<Either<Failure, bool>> call(
      FReminderScheduleSetUsecaseParam params) async {
    return await reminderScheduleRepo.setSchedule(
      flutterLocalNotificationsPlugin: params.flutterLocalNotificationsPlugin,
      time: params.time,
    );
  }
}

class FReminderScheduleSetUsecaseParam extends Equatable {
  final Time time;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  FReminderScheduleSetUsecaseParam({
    @required this.time,
    @required this.flutterLocalNotificationsPlugin,
  });

  @override
  List<Object> get props => [time, flutterLocalNotificationsPlugin];
}
