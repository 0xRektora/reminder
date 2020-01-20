import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../entities/f_c_pill_history_entity.dart';

abstract class FCalendarRepo {
  Future<Either<Failure, List<FCPillHistoryEntity>>> getDayPillHistory({
    @required String date,
    @required String uid,
  });

  /// return a map of dates containing list of [FCPillHistoryEntity]
  /// based on the {month} param
  ///
  /// The function will not return dates before {creationDate} param
  ///
  ///exemple:
  ///
  /// ```
  ///
  /// {
  ///   "2020-01-20": [
  /// FCPillHistoryEntity,
  /// FCPillHistoryEntity,
  /// FCPillHistoryEntity,
  ///    ],
  /// }
  /// ```
  Future<Either<Failure, Map<String, List<FCPillHistoryEntity>>>>
      getMonthPillHistory({
    @required String creationDate,
    @required int year,
    @required int month,
    @required String uid,
  });
}
