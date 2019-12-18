import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:reminder/core/error/exceptions.dart';
import 'package:reminder/features/prescriptions/domain/entities/f_pill_entity.dart';

import '../data/models/c_d_app_pill_model.dart';
import '../domain/repositories/c_d_db_repo.dart';
import '../error/failures.dart';
import 'usecase.dart';

class CAppAllPillUsecase
    implements Usecase<List<FPPillEntity>, CAppGetAllPillParam> {
  CDDbRepo cdDbRepo;

  @override
  // Call [CAppAllPillUsecase] with [CAppGetAllPillParam] as param
  Future<Either<Failure, List<FPPillEntity>>> call(
      CAppGetAllPillParam params) async {
    return await cdDbRepo.allPills(params);
  }
}

class CAppGetAllPillParam {
  final String uid;

  CAppGetAllPillParam({@required this.uid});
}
