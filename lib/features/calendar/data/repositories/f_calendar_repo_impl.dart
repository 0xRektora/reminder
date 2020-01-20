import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:reminder/core/error/exceptions.dart';
import 'package:reminder/features/calendar/data/models/f_c_pill_history_model.dart';
import 'package:reminder/features/prescriptions/domain/entities/f_pill_entity.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/f_c_pill_history_entity.dart';
import '../../domain/repositories/f_calendar_repo.dart';
import '../datasources/f_c_pill_history_datasource.dart';

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
      print(e.message);
      return Left(ServerFailure(message: e.message));
    } on Exception catch (e) {
      print(e.toString());
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
