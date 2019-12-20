import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../features/prescriptions/domain/entities/f_pill_entity.dart';
import '../domain/repositories/c_d_db_repo.dart';
import '../error/failures.dart';
import 'usecase.dart';

class CAppAddPillUsecase implements Usecase<bool, CAppAddPillParams> {
  final CDDbRepo cdDbRepo;

  CAppAddPillUsecase(this.cdDbRepo);

  @override
  Future<Either<Failure, bool>> call(CAppAddPillParams params) {
    return cdDbRepo.addPill(params);
  }
}

class CAppAddPillParams {
  final FPPillEntity fpPillEntity;
  final String uid;

  CAppAddPillParams({@required this.fpPillEntity, @required this.uid});
}
