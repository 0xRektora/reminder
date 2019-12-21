import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/f_reminder_schedule_repo.dart';

class FReminderScheduleRepoImpl implements FReminderScheduleRepo {
  @override
  Future<bool> setSchedule({TimeOfDay timeOfDay}) async {
    try {} on Exception catch (e) {
      throw InternalFailure(message: e.toString());
    }
  }
}
