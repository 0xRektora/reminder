import 'package:flutter/material.dart';

/// ## Frequency type
///
/// enum that contains frequencty of pills to take
/// day, week month
enum FrequencyType { day, week, month }

/// ## Pills class
///
/// Static class that store colors for
/// calendar reminder
class CSPills {
  final Color taken = Colors.green;
  final Color notAllTaken = Colors.grey;
  final Color notTaken = Colors.red;
}
