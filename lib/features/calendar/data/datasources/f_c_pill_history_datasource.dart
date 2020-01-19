import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:reminder/core/error/exceptions.dart';
import 'package:reminder/core/static/c_s_db_routes.dart';
import 'package:reminder/features/calendar/data/models/f_c_pill_history_model.dart';

abstract class FCPillHistoryDatasource {
  Future<FCPillHistoryModel> getDayPillHistory({
    @required String date,
    @required String uid,
  });
  Future<List<FCPillHistoryModel>> getMonthPillHistory({
    @required String date,
    @required String uid,
  });
}

class FCPillHistoryDatasourceImpl implements FCPillHistoryDatasource {
  /// return a [FCPillHistoryModel] of the chosen day
  ///
  /// Params:
  ///
  /// [String] date : format yyyy-mm-dd
  ///
  /// [String] uid
  @override
  Future<FCPillHistoryModel> getDayPillHistory({
    @required String date,
    @required String uid,
  }) async {
    try {
      final DocumentSnapshot snapshot = await Firestore.instance
          .collection(CSDbRoutes.PRESCRIPTIONS)
          .document(uid)
          .collection(CSDbRoutes.EVENTS)
          .document(date)
          .get();

      final int day = int.parse(date.split('-')[1]); // should return dd
      final FCPillHistoryModel pillHistoryModel =
          FCPillHistoryModel.fromSnapshot(
        day: day,
        jsonPillModel: snapshot.data,
      );

      return pillHistoryModel;
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
