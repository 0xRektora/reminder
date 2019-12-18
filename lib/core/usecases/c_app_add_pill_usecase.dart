import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:reminder/features/prescriptions/domain/entities/f_pill_entity.dart';

import '../data/models/c_d_app_pill_model.dart';
import '../domain/repositories/c_d_db_repo.dart';
import '../error/failures.dart';
import 'usecase.dart';

class CAppAddPillUsecase implements Usecase<bool, CAppAddPillParams> {
  CDDbRepo cdDbRepo;

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
