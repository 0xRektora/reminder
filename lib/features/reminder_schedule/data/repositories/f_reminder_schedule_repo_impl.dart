import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder/core/error/exceptions.dart';
import 'package:reminder/core/static/c_s_shared_prefs.dart';
import 'package:reminder/core/utils/c_app_shared_pref_manager.dart';

import 'package:reminder/core/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/f_reminder_schedule_repo.dart';

class FReminderScheduleRepoImpl implements FReminderScheduleRepo {
  final CAppSharedPrefManager cAppSharedPrefManager;

  FReminderScheduleRepoImpl({@required this.cAppSharedPrefManager});

  @override
  Future<Either<Failure, bool>> setSchedule({
    Time time,
    String notificationName,
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) async {
    try {
      // If the notification does't exist, create new one
      if (!cAppSharedPrefManager.notificationExist(notificationName)) {
        final int notificationId = cAppSharedPrefManager.createId();
        final String notificationDescription =
            'Time to take your prescription ${(time.hour).toString().padLeft(2, '0')}:${(time.minute).toString().padLeft(2, '0')}';

        final PrescNotification prescNotification = PrescNotification(
          notificationId,
          notificationName,
          notificationDescription,
          time,
        );

        await _setNotification(
          notificationId: notificationId,
          notificationName: notificationName,
          notificationDescription: notificationDescription,
          time: time,
          flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
        );

        cAppSharedPrefManager.addNotification(prescNotification);

        // Debug purpose
        print(notificationDescription);

        return Right(true);
      } else {
        // Update the notification time
        final String notificationDescription =
            'Time to take your prescription ${(time.hour).toString().padLeft(2, '0')}:${(time.minute).toString().padLeft(2, '0')}';

        final PrescNotification oldNotification =
            cAppSharedPrefManager.getNotification(notificationName);
        final PrescNotification newNotification =
            cAppSharedPrefManager.getNotification(notificationName);
        final int notificationId = newNotification.notificationId;

        await flutterLocalNotificationsPlugin.cancel(
          newNotification.notificationId,
        );

        await _setNotification(
          notificationId: notificationId,
          notificationName: notificationName,
          notificationDescription: notificationDescription,
          time: time,
          flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
        );

        cAppSharedPrefManager.setNotification(
          oldNotification,
          newNotification,
        );

        // Debug purpose
        print(notificationDescription);
        return Right(true);
      }
    } on InternalException catch (e) {
      return Left(InternalFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> unsetSchedule({
    String notificationName,
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) async {
    try {
      if (cAppSharedPrefManager.notificationExist(notificationName)) {
        final PrescNotification prescNotification =
            cAppSharedPrefManager.getNotification(notificationName);
        await flutterLocalNotificationsPlugin.cancel(
          prescNotification.notificationId,
        );
        return Right(true);
      } else {
        return Right(false);
      }
    } on InternalException catch (e) {
      return Left(InternalFailure(message: e.message));
    }
  }

  Future<void> _setNotification({
    @required int notificationId,
    @required Time time,
    @required String notificationName,
    @required String notificationDescription,
    @required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) async {
    final androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      '$notificationId',
      '$notificationName',
      '$notificationDescription',
      priority: Priority.High,
      importance: Importance.High,
      autoCancel: false,
    );
    final iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    final platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
      notificationId,
      notificationName,
      notificationDescription,
      time,
      platformChannelSpecifics,
    );
  }
}
