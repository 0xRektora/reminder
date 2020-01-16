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

  /// Function that return a future boolean of wheather the pill
  /// was taken or not.
  Future<bool> _isPrescTaken({
    @required String uid,
    @required String today,
    @required String pillName,
  }) async {
    final CDAppPillModel historyPillModel = await pillDatasource.getHistoryPill(
      uid: uid,
      date: today,
      pillName: pillName,
    );

    if (historyPillModel == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<PrescNotification>> _prescNotificationFilter({
    @required List<PrescNotification> prescNotification,
    @required String today,
    @required String uid,
    @required DateTime now,
  }) async {
    final List<PrescNotification> result = [];
    for (PrescNotification prescNotif in prescNotification) {
      final bool isTaken = await _isPrescTaken(
        today: today,
        uid: uid,
        pillName: prescNotif.notificationName,
      );

      if (!isTaken) {
        if (now.hour > prescNotif.timeToTake.hour) {
          result.add(prescNotif);
        } else if (now.hour >= prescNotif.timeToTake.hour) {
          if (now.minute >= prescNotif.timeToTake.minute) {
            result.add(prescNotif);
          }
        }
      }
    }

    return result;
  }

  @override
  Future<Either<Failure, List<FReminderPrescPrescNotificationEntity>>>
      listValidate({
    String uid,
  }) async {
    try {
      final List<PrescNotification> prescNotification =
          cAppSharedPrefManager.getNotifications();

      final DateTime now = DateTime.now();
      final String today = CAppConverter.fromDatetimeToString(now);

      final List<PrescNotification> result = await _prescNotificationFilter(
        now: now,
        prescNotification: prescNotification,
        today: today,
        uid: uid,
      );

      final List<FReminderPrescPrescNotificationEntity> castedResult =
          result.map(
        (prescNotif) {
          return FReminderPrescPrescNotificationEntity(
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
    } on ServerException catch (e) {
      return Left(InternalFailure(message: e.message));
    } on Exception catch (e) {
      return Left(InternalFailure(message: e.toString()));
    }
  }
}
