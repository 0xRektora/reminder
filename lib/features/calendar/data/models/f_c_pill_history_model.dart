import 'package:meta/meta.dart';

import '../../../../core/data/models/c_d_app_pill_model.dart';

class FCPillHistoryModel {
  final int day;
  final CDAppPillModel pillModel;

  FCPillHistoryModel({
    this.day,
    this.pillModel,
  });

  factory FCPillHistoryModel.fromSnapshot({
    @required int day,
    @required Map<String, dynamic> jsonPillModel,
  }) {
    final CDAppPillModel appPillModel =
        CDAppPillModel.fromSnapshot(jsonPillModel);

    return FCPillHistoryModel(day: day, pillModel: appPillModel);
  }
}
