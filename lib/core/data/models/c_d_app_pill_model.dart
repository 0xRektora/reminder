import 'package:meta/meta.dart';

import '../../static/c_s_db_routes.dart';
import '../../utils/c_app_converter.dart';

class CDAppPillModel {
  final String pillName;
  final int total;
  final int current;
  final int qtyToTake;
  final int remindAt;
  final DateTime remindWhen;
  bool taken;

  CDAppPillModel(
      {@required this.pillName,
      @required this.total,
      @required this.current,
      @required this.qtyToTake,
      @required this.remindAt,
      @required this.remindWhen,
      @required this.taken});

  Map<String, dynamic> toDoc() {
    return {
      CSDbPillDoc.PILLNAME: this.pillName,
      CSDbPillDoc.TOTAL: this.total,
      CSDbPillDoc.CURRENT: this.current,
      CSDbPillDoc.QTY_TO_TAKE: this.qtyToTake,
      CSDbPillDoc.REMIND_AT: this.remindAt,
      CSDbPillDoc.REMIND_WHEN: CAppConverter.fromTimeToString(this.remindWhen),
      CSDbPillDoc.TAKEN: this.taken,
    };
  }

  factory CDAppPillModel.fromSnapshot(Map<String, dynamic> ds) {
    return CDAppPillModel(
      pillName: ds[CSDbPillDoc.PILLNAME],
      total: ds[CSDbPillDoc.TOTAL],
      current: ds[CSDbPillDoc.CURRENT],
      qtyToTake: ds[CSDbPillDoc.QTY_TO_TAKE],
      remindAt: ds[CSDbPillDoc.REMIND_AT],
      remindWhen: CAppConverter.fromStringToTime(ds[CSDbPillDoc.REMIND_WHEN]),
      taken: ds[CSDbPillDoc.TAKEN],
    );
  }

  static List<CDAppPillModel> fromListSnapshot(
      List<Map<String, dynamic>> listDs) {
    return listDs.map((ds) => CDAppPillModel.fromSnapshot(ds)).toList();
  }
}
