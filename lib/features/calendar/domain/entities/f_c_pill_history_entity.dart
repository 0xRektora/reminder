import '../../../prescriptions/domain/entities/f_pill_entity.dart';

class FCPillHistoryEntity {
  final int day;
  final FPPillEntity fpPillEntity;

  FCPillHistoryEntity({
    this.day,
    this.fpPillEntity,
  });
}
