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
  Future<Either<Failure, List<FCPillHistoryEntity>>> getDayPillHistory({
    @required String date,
    @required String uid,
  }) async {
    try {
      // Get a list of [FCPillHistoryModel] of occured events
      final List<FCPillHistoryModel> listModel =
          await pillHistoryDatasource.getDayPillHistory(
        date: date,
        uid: uid,
      );

      // contains the {listModel} casted to [FCPillHistoryEntity]
      final List<FCPillHistoryEntity> listEntity = [];

      // Populae {listEntity}
      for (FCPillHistoryModel model in listModel) {
        final FPPillEntity pillEntity = FPPillEntity(
          current: model.pillModel.current,
          pillName: model.pillModel.pillName,
          qtyToTake: model.pillModel.qtyToTake,
          remindAt: model.pillModel.remindAt,
          remindWhen: model.pillModel.remindWhen,
          taken: model.pillModel.taken,
          total: model.pillModel.total,
        );
        final FCPillHistoryEntity pillHistoryEntity = FCPillHistoryEntity(
          date: date,
          fpPillEntity: pillEntity,
        );

        listEntity.add(pillHistoryEntity);
      }

      return Right(listEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, List<FCPillHistoryEntity>>>>
      getMonthPillHistory({
    @required String creationDate,
    @required int year,
    @required int month,
    @required String uid,
  }) async {
    try {
      final Map<String, List<FCPillHistoryEntity>> entries = {};
      return Right(entries);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
