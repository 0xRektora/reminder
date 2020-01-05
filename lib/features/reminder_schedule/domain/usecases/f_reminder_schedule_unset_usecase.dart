import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder/core/error/failures.dart';
import 'package:reminder/core/usecases/usecase.dart';
import 'package:reminder/features/reminder_schedule/domain/repositories/f_reminder_schedule_repo.dart';

class FReminderScheduleUnsetUsecase
    implements Usecase<bool, FReminderScheduleUnsetParam> {
  final FReminderScheduleRepo reminderScheduleRepo;

  FReminderScheduleUnsetUsecase({@required this.reminderScheduleRepo});

  @override
  Future<Either<Failure, bool>> call(FReminderScheduleUnsetParam params) async {
    return await reminderScheduleRepo.unsetSchedule(
      notificationName: params.notificationName,
      flutterLocalNotificationsPlugin: params.flutterLocalNotificationsPlugin,
    );
  }
}

class FReminderScheduleUnsetParam extends Equatable {
  final String notificationName;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  FReminderScheduleUnsetParam({
    @required this.notificationName,
    @required this.flutterLocalNotificationsPlugin,
  });

  @override
  List<Object> get props => [
        notificationName,
        flutterLocalNotificationsPlugin,
      ];
}
