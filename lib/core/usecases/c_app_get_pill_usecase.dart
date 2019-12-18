import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../features/prescriptions/domain/entities/f_pill_entity.dart';
import '../domain/repositories/c_d_db_repo.dart';
import '../error/failures.dart';
import 'usecase.dart';

class CAppGetPillUsecase implements Usecase<FPPillEntity, CAppGetPillParam> {
  CDDbRepo cdDbRepo;

  @override
  Future<Either<Failure, FPPillEntity>> call(params) async {
    return await cdDbRepo.getPill(params);
  }
}

class CAppGetPillParam {
  final String uid;
  final String pillName;

  CAppGetPillParam({@required this.uid, @required this.pillName});
}
