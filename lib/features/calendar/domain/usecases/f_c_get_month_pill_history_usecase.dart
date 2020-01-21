import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/f_c_pill_history_entity.dart';
import '../repositories/f_calendar_repo.dart';

class FCGetMonthPillHistoryUsecase
    implements
        Usecase<Map<String, List<FCPillHistoryEntity>>,
            FCGetMonthPillHistoryParam> {
  final FCalendarRepo calendarRepo;

  FCGetMonthPillHistoryUsecase({
    @required this.calendarRepo,
  });

  /// Takes a [FCGetMonthPillHistoryParam] as param
  @override
  Future<Either<Failure, Map<String, List<FCPillHistoryEntity>>>> call(
    FCGetMonthPillHistoryParam param,
  ) {
    return calendarRepo.getMonthPillHistory(
      uid: param.uid,
      year: param.year,
      month: param.month,
      creationDate: param.creationDate,
    );
  }
}

class FCGetMonthPillHistoryParam extends Equatable {
  final String uid;
  final int year;
  final int month;
  final String creationDate;

  FCGetMonthPillHistoryParam({
    @required this.uid,
    @required this.year,
    @required this.month,
    @required this.creationDate,
  });

  @override
  List<Object> get props => [
        uid,
        year,
        month,
        creationDate,
      ];
}
