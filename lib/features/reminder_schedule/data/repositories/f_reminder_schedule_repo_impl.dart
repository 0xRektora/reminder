import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/f_reminder_schedule_repo.dart';

class FReminderScheduleRepoImpl implements FReminderScheduleRepo {
  @override
  Future<Either<Failure, bool>> setSchedule({
    Time time,
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) async {
    try {
      final androidPlatformChannelSpecifics = new AndroidNotificationDetails(
          'repeatDailyAtTime channel id',
          'repeatDailyAtTime channel name',
          'repeatDailyAtTime description');
      final iOSPlatformChannelSpecifics = new IOSNotificationDetails();
      final platformChannelSpecifics = new NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.showDailyAtTime(
          0,
          'show daily title',
          'Daily notification shown at approximately ${(time.hour).toString().padLeft(2, '0')}:${(time.minute).toString().padLeft(2, '0')}:${(time.second).toString().padLeft(2, '0')}',
          time,
          platformChannelSpecifics);
      return Right(true);
    } on Exception catch (e) {
      throw InternalFailure(message: e.toString());
    }
  }
}
