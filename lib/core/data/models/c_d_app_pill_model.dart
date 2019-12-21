import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:reminder/core/static/c_s_db_routes.dart';

class CDAppPillModel {
  final String pillName;
  final int total;
  final int current;
  final int qtyToTake;
  final int remindAt;
  final DateTime remindWhen;
  final bool taken;

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
      CSDbPillDoc.REMIND_WHEN:
          "${this.remindWhen.hour}:${this.remindWhen.minute.toString().padLeft(2, '0')}",
      CSDbPillDoc.TAKEN: this.taken,
    };
  }

  factory CDAppPillModel.fromSnapshot(Map<String, dynamic> ds) {
    // TODO test the string to datetime
    return CDAppPillModel(
      pillName: ds[CSDbPillDoc.PILLNAME],
      total: ds[CSDbPillDoc.TOTAL],
      current: ds[CSDbPillDoc.CURRENT],
      qtyToTake: ds[CSDbPillDoc.QTY_TO_TAKE],
      remindAt: ds[CSDbPillDoc.REMIND_AT],
      remindWhen:
          DateTime.parse("1970-01-01 ${ds[CSDbPillDoc.REMIND_WHEN]}:00.00"),
      taken: ds[CSDbPillDoc.TAKEN],
    );
  }

  static List<CDAppPillModel> fromListSnapshot(
      List<Map<String, dynamic>> listDs) {
    return listDs.map((ds) => CDAppPillModel.fromSnapshot(ds)).toList();
  }
}
