import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';

class FReminderPrescPrescNotificationEntity {
  final int notificationId;
  final String notificationName;
  final String notificationDetails;
  final Time timeToTake;

  FReminderPrescPrescNotificationEntity({
    @required this.notificationId,
    @required this.notificationName,
    @required this.notificationDetails,
    @required this.timeToTake,
  });
}
