import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder/core/utils/c_app_converter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../error/exceptions.dart';
import '../static/c_s_shared_prefs.dart';

class _NotificationData {
  final int counterId;
  final List<PrescNotification> notifications;

  _NotificationData(
    this.counterId,
    this.notifications,
  );

  factory _NotificationData.fromJson(
      Map<String, dynamic> notificationDataJson) {
    final int counterId = notificationDataJson['counterId'] ?? 0;
    final List<dynamic> notificationsToCast =
        (notificationDataJson['notifications'] as List);
    final List<PrescNotification> notifications = notificationsToCast
        .map(
          (notificationObject) => PrescNotification.fromJson(
            (notificationObject as Map<String, dynamic>),
          ),
        )
        .toList();

    return _NotificationData(
      counterId,
      notifications,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'counterId': this.counterId,
      'notifications': this
          .notifications
          .map((prescNotification) => prescNotification.toJson())
          .toList(),
    };
  }
}

class PrescNotification {
  final int notificationId;
  final String notificationName;
  final String notificationDetails;
  final Time timeToTake;

  PrescNotification(
    this.notificationId,
    this.notificationName,
    this.notificationDetails,
    this.timeToTake,
  );

  factory PrescNotification.fromJson(
      Map<String, dynamic> prescNotificationJson) {
    DateTime dateTime =
        CAppConverter.fromStringToDatetime(prescNotificationJson['timeToTake']);
    Time time = Time(
      dateTime.hour,
      dateTime.minute,
    );
    return PrescNotification(
      prescNotificationJson['notificationId'],
      prescNotificationJson['notificationName'],
      prescNotificationJson['notificationDetails'],
      time,
    );
  }
  Map<String, dynamic> toJson() {
    DateTime dateTime = DateTime.parse(
      "1970-01-01 ${this.timeToTake.hour.toString().padLeft(2, '0')}:${this.timeToTake.minute.toString().padLeft(2, '0')}:00.00",
    );
    String timeToTake = CAppConverter.fromDatetimeToString(dateTime);
    return {
      'notificationId': this.notificationId,
      'notificationName': this.notificationName,
      'notificationDetails': this.notificationDetails,
      'timeToTake': timeToTake,
    };
  }
}

abstract class CAppSharedPrefManager {
  void _initNotificationData();

  void addNotification(PrescNotification prescNotification);
  void removeNotification(PrescNotification prescNotification);
  PrescNotification getNotification(String name);
  void setNotification(
    PrescNotification oldNotification,
    PrescNotification newPrescNotification,
  );

  bool notificationExist(String name);

  int createId();
}

class CAppSharedPrefManagerImpl implements CAppSharedPrefManager {
  SharedPreferences _sharedPreferences;

  CAppSharedPrefManagerImpl() {
    _init();
  }

  void _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  void _initNotificationData() {
    try {
      final bool exist =
          _sharedPreferences.containsKey(CSSharedPrefs.NOTIFICATION_DATA);
      if (!exist) {
        final notificationData = _NotificationData(0, []);

        _sharedPreferences.setString(
          CSSharedPrefs.NOTIFICATION_DATA,
          _packPayload(notificationData.toJson()),
        );
      } else {
        print(_sharedPreferences.getString(CSSharedPrefs.NOTIFICATION_DATA));
      }
    } on Exception catch (e) {
      throw InternalException(message: e.toString());
    }
  }

  @override
  void addNotification(PrescNotification prescNotification) {
    try {
      _initNotificationData();

      final _NotificationData _notificationData = _getNotificationData();
      _notificationData.notifications.add(prescNotification);

      _setNotificationData(_notificationData);
    } on Exception catch (e) {
      throw InternalException(message: e.toString());
    }
  }

  @override
  void removeNotification(PrescNotification prescNotification) {
    try {
      _initNotificationData();

      final _NotificationData _notificationData = _getNotificationData();
      _notificationData.notifications.removeWhere(
        (item) => item.notificationName == prescNotification.notificationName,
      );

      _setNotificationData(_notificationData);
    } on Exception catch (e) {
      throw InternalException(message: e.toString());
    }
  }

  @override
  PrescNotification getNotification(String name) {
    try {
      _initNotificationData();

      final _NotificationData _notificationData = _getNotificationData();
      if (_notificationData.notifications.every(
        (prescription) => prescription.notificationName == name,
      )) {
        return _notificationData.notifications
            .where(
              (prescription) => prescription.notificationName == name,
            )
            .toList()[0];
      } else {
        throw InternalException(message: "notification don't exist");
      }
    } on Exception catch (e) {
      throw InternalException(message: e.toString());
    }
  }

  @override
  void setNotification(
    PrescNotification oldPrescNotification,
    PrescNotification newPrescNotification,
  ) {
    try {
      _initNotificationData();

      final _NotificationData _notificationData = _getNotificationData();
      if (_notificationData.notifications.every(
        (prescription) =>
            prescription.notificationName ==
            oldPrescNotification.notificationName,
      )) {
        int notificationIndex = _notificationData.notifications.indexWhere(
          (prescription) =>
              prescription.notificationName ==
              oldPrescNotification.notificationName,
        );

        _notificationData.notifications[notificationIndex] =
            newPrescNotification;
        _setNotificationData(_notificationData);
      } else {
        throw InternalException(message: "notification don't exist");
      }
    } on Exception catch (e) {
      throw InternalException(message: e.toString());
    }
  }

  @override
  bool notificationExist(String name) {
    try {
      _initNotificationData();

      final _NotificationData _notificationData = _getNotificationData();
      if (_notificationData.notifications.length == 0) {
        print('notifications lenght is 0');
        return false;
      } else if (_notificationData.notifications.every(
        (prescription) => prescription.notificationName == name,
      )) {
        print('notifications exist');
        return true;
      } else {
        print('notifications doest exist');
        return false;
      }
    } on Exception catch (e) {
      throw InternalException(message: e.toString());
    }
  }

  @override
  int createId() {
    try {
      _initNotificationData();

      final _NotificationData _notificationData = _getNotificationData();

      return _notificationData.counterId + 1;
    } on Exception catch (e) {
      throw InternalException(message: e.toString());
    }
  }

  void _setNotificationData(_NotificationData _notificationData) {
    String _notificationDataJson = _packPayload(
      _notificationData.toJson(),
    );

    _sharedPreferences.setString(
      CSSharedPrefs.NOTIFICATION_DATA,
      _notificationDataJson,
    );
  }

  _NotificationData _getNotificationData() {
    final String notificationDataJson =
        _sharedPreferences.getString(CSSharedPrefs.NOTIFICATION_DATA);
    return _NotificationData.fromJson(
      _unpackPayload(
        notificationDataJson,
      ),
    );
  }

  String _packPayload(Map<String, dynamic> data) {
    return jsonEncode(data);
  }

  Map<String, dynamic> _unpackPayload(String data) {
    return jsonDecode(data);
  }
}
