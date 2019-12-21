import 'package:flutter/material.dart';

abstract class FReminderScheduleRepo {
  Future<bool> setSchedule({@required TimeOfDay timeOfDay});
}
