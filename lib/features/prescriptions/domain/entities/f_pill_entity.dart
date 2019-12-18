import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class FPPillEntity extends Equatable {
  final String pillName;
  final int total;
  final int current;
  final int qtyToTake;
  final int remindAt;
  final DateTime remindWhen;
  final bool taken;

  FPPillEntity({
    @required this.pillName,
    @required this.total,
    @required this.current,
    @required this.qtyToTake,
    @required this.remindAt,
    @required this.remindWhen,
    @required this.taken,
  });

  @override
  List<Object> get props => [
        pillName,
        total,
        current,
        qtyToTake,
        remindAt,
        remindWhen,
        taken,
      ];
}
