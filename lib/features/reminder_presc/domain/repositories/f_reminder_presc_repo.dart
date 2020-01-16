import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../entities/f_reminder_presc_presc_notification_entity.dart';

abstract class FReminderPrescRepo {
  Future<Either<Failure, List<FReminderPrescPrescNotificationEntity>>>
      listValidate({
    @required String uid,
  });
}
