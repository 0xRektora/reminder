import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/c_app_shared_pref_manager.dart';
import '../../domain/entities/f_reminder_presc_presc_notification_entity.dart';
import '../../domain/repositories/f_reminder_presc_repo.dart';

class FReminderPrescRepoImpl extends FReminderPrescRepo {
  final CAppSharedPrefManager cAppSharedPrefManager;

  FReminderPrescRepoImpl({@required this.cAppSharedPrefManager});

  // TODO implement test if taken today
  @override
  Either<Failure, List<FReminderPrescPrescNotificationEntity>> listValidate({
    String uid,
  }) {
    try {
      final List<PrescNotification> prescNotification =
          cAppSharedPrefManager.getNotifications();

      final DateTime now = DateTime.now();

      final List<PrescNotification> result = prescNotification.map(
        (prescNotif) {
          if (now.hour > prescNotif.timeToTake.hour) {
            return prescNotif;
          } else if (now.hour >= prescNotif.timeToTake.hour) {
            if (now.minute >= prescNotif.timeToTake.minute) {
              return prescNotif;
            }
          }
        },
      ).toList();

      final List<FReminderPrescPrescNotificationEntity> castedResult =
          result.map(
        (prescNotif) {
          FReminderPrescPrescNotificationEntity(
            notificationDetails: prescNotif.notificationDetails,
            notificationId: prescNotif.notificationId,
            notificationName: prescNotif.notificationName,
            timeToTake: prescNotif.timeToTake,
          );
        },
      ).toList();

      return Right(castedResult);
    } on InternalException catch (e) {
      return Left(InternalFailure(message: e.message));
    } on Exception catch (e) {
      return Left(InternalFailure(message: e.toString()));
    }
  }
}
