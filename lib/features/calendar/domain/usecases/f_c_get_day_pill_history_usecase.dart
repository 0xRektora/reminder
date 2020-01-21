import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/f_c_pill_history_entity.dart';
import '../repositories/f_calendar_repo.dart';

class FCGetDayPillHistoryUsecase
    implements Usecase<List<FCPillHistoryEntity>, FCGetDayPillHistoryParam> {
  final FCalendarRepo calendarRepo;

  FCGetDayPillHistoryUsecase({
    @required this.calendarRepo,
  });

  /// Takes a [FCGetDayPillHistoryParam] as param
  @override
  Future<Either<Failure, List<FCPillHistoryEntity>>> call(
    FCGetDayPillHistoryParam param,
  ) {
    return null;
  }
}

class FCGetDayPillHistoryParam extends Equatable {
  final String date;
  final String uid;

  FCGetDayPillHistoryParam({
    @required this.date,
    @required this.uid,
  });

  @override
  List<Object> get props => [
        date,
        uid,
      ];
}
