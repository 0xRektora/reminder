import 'package:dartz/dartz.dart';
import 'package:reminder/core/usecases/c_app_delete_pill_usecase.dart';

import '../../../features/prescriptions/domain/entities/f_pill_entity.dart';
import '../../error/failures.dart';
import '../../usecases/c_app_add_pill_usecase.dart';
import '../../usecases/c_app_all_pill_usecase.dart';
import '../../usecases/c_app_get_pill_usecase.dart';

abstract class CDDbRepo {
  Future<Either<Failure, bool>> deletePill(
      CAppDeletePillParam cAppDeletePillParam);
  Future<Either<Failure, bool>> addPill(CAppAddPillParams cAppAddPillParams);
  Future<Either<Failure, FPPillEntity>> getPill(
      CAppGetPillParam cAppGetPillParam);
  Future<Either<Failure, List<FPPillEntity>>> allPills(
      CAppGetAllPillParam cAppGetAllPillParam);
}
