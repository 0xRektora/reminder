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
    @required int year,
    @required int month,
    @required String uid,
  });
}

class FCPillHistoryDatasourceImpl implements FCPillHistoryDatasource {
  /// Return a list of [String ] of the pill names saved on the db
  ///
  /// Takes a [String] {uid} as param
  Future<List<String>> _getPillNames({
    @required String uid,
  }) async {
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

    return pillNames;
  }

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

      final List<String> pillNames = await _getPillNames(
        uid: uid,
      );

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

  /// Return a list of [FCPillHistoryModel]
  @override
  Future<List<FCPillHistoryModel>> getMonthPillHistory({
    @required int year,
    @required int month,
    @required String uid,
  }) async {
    try {
      // The list of [FCPillHistoryModel] that we'll return
      final List<FCPillHistoryModel> monthPillHistory = [];

      // Get the names of pill saved on the DB
      final List<String> pillNames = await _getPillNames(
        uid: uid,
      );

      // for each pill
      for (String pillName in pillNames) {
        final snapshotEntries = await Firestore.instance
            .collection(CSDbRoutes.PRESCRIPTIONS)
            .document(uid)
            .collection(CSDbRoutes.EVENTS)
            .document(pillName)
            .collection(year.toString())
            .document(month.toString())
            .get();
      }

      return monthPillHistory;
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
