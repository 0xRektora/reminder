import 'package:meta/meta.dart';

import '../../../../core/data/models/c_d_app_pill_model.dart';

class FCPillHistoryModel {
  final int year;
  final int month;
  final int day;
  final CDAppPillModel pillModel;

  FCPillHistoryModel({
    @required this.year,
    @required this.month,
    @required this.day,
    @required this.pillModel,
  });

  Map<String, dynamic> toDoc() {
    final Map<String, dynamic> doc = {
      '$day': {
        '${pillModel.pillName}': this.pillModel.toDoc(),
      },
    };
    return doc;
  }

  factory FCPillHistoryModel.fromSnapshot({
    @required int year,
    @required int month,
    @required int day,
    @required Map<String, dynamic> jsonPillModel,
  }) {
    final CDAppPillModel appPillModel =
        CDAppPillModel.fromSnapshot(jsonPillModel);

    return FCPillHistoryModel(
      year: year,
      month: month,
      day: day,
      pillModel: appPillModel,
    );
  }
}
