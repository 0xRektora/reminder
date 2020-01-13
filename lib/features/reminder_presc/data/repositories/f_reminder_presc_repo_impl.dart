import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:reminder/core/data/models/c_d_app_pill_model.dart';
import 'package:reminder/core/utils/c_app_converter.dart';

import '../../../../core/data/datasources/c_d_pill_datasource.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/c_app_shared_pref_manager.dart';
import '../../domain/entities/f_reminder_presc_presc_notification_entity.dart';
import '../../domain/repositories/f_reminder_presc_repo.dart';

class FReminderPrescRepoImpl extends FReminderPrescRepo {
  final CAppSharedPrefManager cAppSharedPrefManager;
  final CDPillDatasource pillDatasource;

  FReminderPrescRepoImpl({
    @required this.cAppSharedPrefManager,
    @required this.pillDatasource,
  });

  Future<bool> _isPrescTaken({
    @required String uid,
    @required String today,
  }) async {
    final CDAppPillModel historyPillModel = await pillDatasource.getHistoryPill(
      uid: uid,
      date: today,
    );

    if (historyPillModel == null) {
      return false;
    } else {
      return true;
    }
  }

  // TODO implement test if taken today
  Future<PrescNotification> _prescNotificationFilter({
    @required PrescNotification prescNotif,
    @required String today,
    @required String uid,
    @required DateTime now,
  }) async {
    if (await _isPrescTaken(today: today, uid: uid)) {
      if (now.hour > prescNotif.timeToTake.hour) {
        return prescNotif;
      } else if (now.hour >= prescNotif.timeToTake.hour) {
        if (now.minute >= prescNotif.timeToTake.minute) {
          return prescNotif;
        }
      }
    }
  }

  @override
  Either<Failure, List<FReminderPrescPrescNotificationEntity>> listValidate({
    String uid,
  }) {
    try {
      final List<PrescNotification> prescNotification =
          cAppSharedPrefManager.getNotifications();

      final DateTime now = DateTime.now();
      final String today = CAppConverter.fromDatetimeToString(now);

      final List<PrescNotification> result = prescNotification
          .map(
            (prescNotif) async => await _prescNotificationFilter(
              now: now,
              prescNotif: prescNotif,
              today: today,
              uid: uid,
            ),
          )
          .toList();

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
