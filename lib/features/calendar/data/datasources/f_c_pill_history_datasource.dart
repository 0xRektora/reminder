import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:reminder/core/error/exceptions.dart';
import 'package:reminder/core/static/c_s_db_routes.dart';
import 'package:reminder/features/calendar/data/models/f_c_pill_history_model.dart';

abstract class FCPillHistoryDatasource {
  Future<List<FCPillHistoryModel>> getDayPillHistory({
    @required String date,
    @required String uid,
  });
  Future<List<FCPillHistoryModel>> getMonthPillHistory({
    @required String date,
    @required String uid,
  });
}

class FCPillHistoryDatasourceImpl implements FCPillHistoryDatasource {
  // TODO rework, nonsense
  /// return a [FCPillHistoryModel] of the chosen day
  ///
  /// Params:
  ///
  /// [String] date : format yyyy-mm-dd
  ///
  /// [String] uid
  @override
  Future<List<FCPillHistoryModel>> getDayPillHistory({
    @required String date,
    @required String uid,
  }) async {
    try {
      // Split the date
      final List<String> splittedDate = date.split("-");
      final String year = splittedDate[0];
      final String month = splittedDate[1];
      final String day = splittedDate[2];

      // Get a list documents of pills
      final pillDocuments = await Firestore.instance
          .collection(CSDbRoutes.PRESCRIPTIONS)
          .document(uid)
          .collection(CSDbPillDoc.PATH)
          .getDocuments();

      // contains registered pill names
      final List<String> pillNames = [];

      // populate {pillNames}
      for (DocumentSnapshot pillDoc in pillDocuments.documents) {
        pillNames.add(pillDoc.documentID);
      }

      // list of [FCPillHistoryModel]
      final List<FCPillHistoryModel> pillHistoryModels = [];

      // populate {pillHistoryModels}
      for (String pillName in pillNames) {
        final DocumentSnapshot queryDocument = await Firestore.instance
            .collection(CSDbRoutes.PRESCRIPTIONS)
            .document(uid)
            .collection(CSDbRoutes.EVENTS)
            .document(pillName)
            .collection(year)
            .document(month)
            .collection(day)
            .document(date)
            .get();

        final FCPillHistoryModel pillHistorymodel =
            FCPillHistoryModel.fromSnapshot(
          date: date,
          jsonPillModel: queryDocument.data,
        );

        pillHistoryModels.add(pillHistorymodel);
      }

      return pillHistoryModels;
    } on Exception catch (e) {
      print("f_c_pill_history_datasource/getDayPillHistory :" + e.toString());
      throw ServerException(message: e.toString());
    }
  }

  /// return a [List<FCPillHistoryModel>] of the chosen month
  ///
  /// Params:
  ///
  /// [String] date : format yyyy-mm
  ///
  /// [String] uid
  @override
  Future<List<FCPillHistoryModel>> getMonthPillHistory({
    @required String date,
    @required String uid,
  }) async {
    try {} on Exception catch (e) {
      print("f_c_pill_history_datasource/getMonthPillHistory :" + e.toString());
      throw ServerException(message: e.toString());
    }
  }
}
