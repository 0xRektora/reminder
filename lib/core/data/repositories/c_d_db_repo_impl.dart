import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:reminder/core/error/exceptions.dart';
import 'package:reminder/core/usecases/c_app_delete_pill_usecase.dart';
import 'package:reminder/features/prescriptions/domain/entities/f_pill_entity.dart';

import '../../domain/repositories/c_d_db_repo.dart';
import '../../error/failures.dart';
import '../../usecases/c_app_add_pill_usecase.dart';
import '../../usecases/c_app_all_pill_usecase.dart';
import '../../usecases/c_app_get_pill_usecase.dart';
import '../datasources/c_d_pill_datasource.dart';
import '../models/c_d_app_pill_model.dart';

class CDDbRepoImpl implements CDDbRepo {
  CDPillDatasource cdPillDatasource;

  CDDbRepoImpl({@required this.cdPillDatasource});

  @override
  Future<Either<Failure, bool>> addPill(
      CAppAddPillParams cAppAddPillParams) async {
    try {
      final pillModel = _fromEntityToModel(cAppAddPillParams.fpPillEntity);
      final result = await cdPillDatasource.addPill(
        appPillModel: pillModel,
        uid: cAppAddPillParams.uid,
      );

      return Right(result);
    } on ServerException {
      return Left(
        ServerFailure(message: "Usecase add pill error :"),
      );
    }
  }

  @override
  Future<Either<Failure, List<FPPillEntity>>> allPills(
      CAppGetAllPillParam cAppGetAllPillParam) async {
    try {
      final allPillModel = await cdPillDatasource.allPill(
        uid: cAppGetAllPillParam.uid,
      );
      final allPillEntity = allPillModel
          .map(
            (pillModel) => _fromModelToEntity(pillModel),
          )
          .toList();

      return Right(allPillEntity);
    } on ServerException {
      return Left(
        ServerFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, FPPillEntity>> getPill(
      CAppGetPillParam cAppGetPillParam) async {
    try {
      final pillModel = await cdPillDatasource.getPill(
        pillName: cAppGetPillParam.pillName,
        uid: cAppGetPillParam.uid,
      );
      final pillEntity = _fromModelToEntity(pillModel);

      return Right(pillEntity);
    } on ServerException {
      return Left(
        ServerFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> deletePill(
      CAppDeletePillParam cAppDeletePillParam) async {
    try {
      final result = await cdPillDatasource.deletePill(
        pillName: cAppDeletePillParam.pillName,
        uid: cAppDeletePillParam.uid,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.toString(),
        ),
      );
    }
  }

  FPPillEntity _fromModelToEntity(CDAppPillModel cdAppPillModel) {
    return FPPillEntity(
      pillName: cdAppPillModel.pillName,
      total: cdAppPillModel.total,
      current: cdAppPillModel.current,
      qtyToTake: cdAppPillModel.qtyToTake,
      remindWhen: cdAppPillModel.remindWhen,
      remindAt: cdAppPillModel.remindAt,
      taken: false,
    );
  }

  CDAppPillModel _fromEntityToModel(FPPillEntity fpPillEntity) {
    return CDAppPillModel(
      pillName: fpPillEntity.pillName,
      total: fpPillEntity.total,
      current: fpPillEntity.current,
      qtyToTake: fpPillEntity.qtyToTake,
      remindWhen: fpPillEntity.remindWhen,
      remindAt: fpPillEntity.remindAt,
      taken: false,
    );
  }
}
