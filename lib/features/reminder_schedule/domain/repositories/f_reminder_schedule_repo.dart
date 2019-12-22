import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../../core/error/failures.dart';

abstract class FReminderScheduleRepo {
  Future<Either<Failure, bool>> setSchedule({
    @required Time time,
    @required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  });
}
