import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../domain/repositories/c_d_db_repo.dart';
import '../error/failures.dart';
import 'usecase.dart';

class CAppDeletePillUsecase implements Usecase<bool, CAppDeletePillParam> {
  final CDDbRepo cdDbRepo;

  CAppDeletePillUsecase(this.cdDbRepo);

  @override
  Future<Either<Failure, bool>> call(params) async {
    return await cdDbRepo.deletePill(params);
  }
}

class CAppDeletePillParam {
  final String uid;
  final String pillName;

  CAppDeletePillParam({@required this.uid, @required this.pillName});
}
