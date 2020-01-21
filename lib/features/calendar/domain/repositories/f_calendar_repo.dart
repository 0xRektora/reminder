import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../entities/f_c_pill_history_entity.dart';

abstract class FCalendarRepo {
  /// return a map of dates containing list of [FCPillHistoryEntity]
  /// based on the {year} {month} params
  ///
  /// The function will not return dates before {creationDate} param

  Future<Either<Failure, Map<String, List<FCPillHistoryEntity>>>>
      getMonthPillHistory({
    @required String uid,
    @required int year,
    @required int month,
    @required String creationDate,
  });
}
