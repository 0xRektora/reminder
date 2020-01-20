import '../../../prescriptions/domain/entities/f_pill_entity.dart';

class FCPillHistoryEntity {
  final String date;
  final FPPillEntity fpPillEntity;

  FCPillHistoryEntity({
    this.date,
    this.fpPillEntity,
  });
}
