import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../../core/error/failures.dart';

abstract class FReminderScheduleRepo {
  Future<Either<Failure, bool>> unsetSchedule({
    @required int notificationId,
    @required String notificationName,
    @required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  });

  Future<Either<Failure, bool>> setSchedule({
    @required Time time,
    @required String notificationName,
    @required int notificationId,
    @required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  });

  Future<Either<Failure, int>> getId({@required String name});
}
