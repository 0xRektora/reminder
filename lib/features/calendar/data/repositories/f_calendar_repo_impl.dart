import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../prescriptions/domain/entities/f_pill_entity.dart';
import '../../domain/entities/f_c_pill_history_entity.dart';
import '../../domain/repositories/f_calendar_repo.dart';
import '../datasources/f_c_pill_history_datasource.dart';
import '../models/f_c_pill_history_model.dart';

class FCalendarRepoImpl implements FCalendarRepo {
  final FCPillHistoryDatasource pillHistoryDatasource;

  FCalendarRepoImpl({
    @required this.pillHistoryDatasource,
  });

  @override
  Future<Either<Failure, Map<String, List<FCPillHistoryEntity>>>>
      getMonthPillHistory({
    @required String uid,
    @required int year,
    @required int month,
    @required String creationDate,
  }) async {
    try {
      final Map<String, List<FCPillHistoryEntity>> entries = {};
      pillHistoryDatasource.getMonthPillHistory(
        uid: uid,
        year: year,
        month: month,
        creationDate: creationDate,
      );
      return Right(entries);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
