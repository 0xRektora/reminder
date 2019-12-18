import 'package:dartz/dartz.dart';

import '../../../features/prescriptions/domain/entities/f_pill_entity.dart';
import '../../error/failures.dart';
import '../../usecases/c_app_add_pill_usecase.dart';
import '../../usecases/c_app_all_pill_usecase.dart';
import '../../usecases/c_app_get_pill_usecase.dart';

abstract class CDDbRepo {
  Future<Either<Failure, bool>> addPill(CAppAddPillParams cAppAddPillParams);
  Future<Either<Failure, FPPillEntity>> getPill(
      CAppGetPillParam cAppGetPillParam);
  Future<Either<Failure, List<FPPillEntity>>> allPills(
      CAppGetAllPillParam cAppGetAllPillParam);
}
