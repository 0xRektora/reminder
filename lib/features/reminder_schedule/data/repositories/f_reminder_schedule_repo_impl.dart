import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder/core/static/c_s_shared_prefs.dart';
import 'package:reminder/core/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/f_reminder_schedule_repo.dart';

class FReminderScheduleRepoImpl implements FReminderScheduleRepo {
  @override
  Future<Either<Failure, bool>> setSchedule({
    Time time,
    String notificationName,
    int notificationId,
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) async {
    try {
      // Check if the notification is set
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isSet =
          prefs.getBool(CSSharedPrefs.ALARM + notificationName) ?? false;

      final androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '$notificationId',
        '$notificationName',
        'Time to take your prescription ${(time.hour).toString().padLeft(2, '0')}:${(time.minute).toString().padLeft(2, '0')}',
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
          'Time to take your prescription ${(time.hour).toString().padLeft(2, '0')}:${(time.minute).toString().padLeft(2, '0')}',
          time,
          platformChannelSpecifics,
          payload: PackPayload.call({"name": notificationName}));

      prefs.setBool(CSSharedPrefs.ALARM + notificationName, true);

      print(
          "notification set for ${(time.hour).toString().padLeft(2, '0')}:${(time.minute).toString().padLeft(2, '0')}");

      return Right(true);
    } on Exception catch (e) {
      throw InternalFailure(message: e.toString());
    }
  }

  @override
  Future<Either<Failure, int>> getId({@required String name}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int globalCounter = prefs.get(CSSharedPrefs.GLOBAL_COUNTER) ?? 0;
      int namedId = 0;

      // If the globalCounter is 0, init it
      if (globalCounter == 0) {
        prefs.setInt(CSSharedPrefs.GLOBAL_COUNTER, 1);
        namedId = 1;
        prefs.setInt(CSSharedPrefs.COUNTER + name, namedId);
      } else {
        // If not check if the pref exist
        namedId = prefs.get(name) ?? 0;
        if (namedId == 0) {
          // if it doest exist create it and increment the global counter
          globalCounter = prefs.get(CSSharedPrefs.GLOBAL_COUNTER);
          namedId = globalCounter + 1;
          prefs.setInt(CSSharedPrefs.COUNTER + name, namedId);
          prefs.setInt(CSSharedPrefs.GLOBAL_COUNTER, namedId);
        }
      }

      return Right(namedId);
    } on Exception catch (e) {
      throw InternalFailure(message: e.toString());
    }
  }

  @override
  Future<Either<Failure, bool>> unsetSchedule({
    int notificationId,
    String notificationName,
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isSet =
          prefs.getBool(CSSharedPrefs.ALARM + notificationName) ?? false;
      if (isSet) {
        await flutterLocalNotificationsPlugin.cancel(notificationId);
        prefs.setBool(CSSharedPrefs.ALARM + notificationName, false);
      }

      return Right(true);
    } on Exception catch (e) {
      throw InternalFailure(message: e.toString());
    }
  }
}
