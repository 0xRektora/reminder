import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../entities/f_c_pill_history_entity.dart';

abstract class FCalendarRepo {
  Future<Either<Failure, List<FCPillHistoryEntity>>> getDayPillHistory({
    @required String date,
    @required String uid,
  });
}
