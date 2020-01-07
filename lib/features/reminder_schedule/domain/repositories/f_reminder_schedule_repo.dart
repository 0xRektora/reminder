import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../../core/error/failures.dart';
import '../../../prescriptions/domain/entities/f_pill_entity.dart';

abstract class FReminderScheduleRepo {
  Future<Either<Failure, bool>> unsetSchedule({
    @required String notificationName,
    @required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  });

  Future<Either<Failure, bool>> setSchedule({
    @required Time time,
    @required String notificationName,
    @required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  });

  Future<Either<Failure, bool>> validate({
    @required String uid,
    @required FPPillEntity fpPillEntity,
    @required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  });
}
