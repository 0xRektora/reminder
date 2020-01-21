import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:reminder/core/data/models/c_d_app_pill_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/static/c_s_db_routes.dart';
import '../models/f_c_pill_history_model.dart';

abstract class FCPillHistoryDatasource {
  Future<List<FCPillHistoryModel>> getMonthPillHistory({
    @required String uid,
    @required int year,
    @required int month,
    @required String creationDate,
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

  /// Return a list of [FCPillHistoryModel]
  @override
  Future<List<FCPillHistoryModel>> getMonthPillHistory({
    @required String uid,
    @required int year,
    @required int month,
    @required String creationDate,
  }) async {
    try {
      // The list of [FCPillHistoryModel] that we'll return
      final List<FCPillHistoryModel> monthPillHistory = [];

      // Get the names of pill saved on the DB
      final List<String> pillNames = await _getPillNames(
        uid: uid,
      );

      // populate {monthPillHistory}
      for (String pillName in pillNames) {
        final snapshotEntries = await Firestore.instance
            .collection(CSDbRoutes.PRESCRIPTIONS)
            .document(uid)
            .collection(CSDbRoutes.EVENTS)
            .document(pillName)
            .collection(year.toString())
            .document(month.toString())
            .get();

        for (String day in snapshotEntries.data.keys) {
          final Map<String, dynamic> snapshotData =
              (snapshotEntries.data[day][pillName] as Map<dynamic, dynamic>)
                  .cast<String, dynamic>();
          final CDAppPillModel pillModel =
              CDAppPillModel.fromSnapshot(snapshotData);

          final FCPillHistoryModel pillHistoryModel = FCPillHistoryModel(
            year: year,
            month: month,
            day: int.parse(day),
            pillModel: pillModel,
          );
          monthPillHistory.add(pillHistoryModel);
        }
      }
      print(monthPillHistory.toString());

      return monthPillHistory;
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
