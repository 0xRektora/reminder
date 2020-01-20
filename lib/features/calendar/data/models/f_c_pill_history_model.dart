import 'package:meta/meta.dart';

import '../../../../core/data/models/c_d_app_pill_model.dart';

class FCPillHistoryModel {
  final String date;
  final CDAppPillModel pillModel;

  FCPillHistoryModel({
    this.date,
    this.pillModel,
  });

  Map<String, dynamic> toDoc() {
    final Map<String, dynamic> doc = this.pillModel.toDoc()
      ..addAll({
        'date': this.date,
      });

    return doc;
  }

  factory FCPillHistoryModel.fromSnapshot({
    @required String date,
    @required Map<String, dynamic> jsonPillModel,
  }) {
    final CDAppPillModel appPillModel =
        CDAppPillModel.fromSnapshot(jsonPillModel);

    return FCPillHistoryModel(date: date, pillModel: appPillModel);
  }
}
