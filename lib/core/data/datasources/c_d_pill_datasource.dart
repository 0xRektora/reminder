import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../error/exceptions.dart';
import '../../static/c_s_db_routes.dart';
import '../models/c_d_app_pill_model.dart';

abstract class CDPillDatasource {
  Future<bool> deletePill({@required String uid, @required String pillName});
  Future<CDAppPillModel> getPill(
      {@required String uid, @required String pillName});
  Future<List<CDAppPillModel>> allPill({@required String uid});
  Future<bool> addPill(
      {@required CDAppPillModel appPillModel, @required String uid});
}

class CDPillDatasourceImpl implements CDPillDatasource {
  @override
  Future<bool> addPill(
      {@required CDAppPillModel appPillModel, @required String uid}) async {
    try {
      await Firestore.instance
          .collection(CSDbRoutes.PRESCRIPTIONS)
          .document(uid)
          .collection(CSDbPillDoc.PATH)
          .document(appPillModel.pillName)
          .setData(appPillModel.toDoc());
      return true;
    } on ServerException catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<CDAppPillModel>> allPill({String uid}) async {
    try {
      final ds = await Firestore.instance
          .collection(CSDbRoutes.PRESCRIPTIONS)
          .document(uid)
          .collection(CSDbPillDoc.PATH)
          .getDocuments();
      final listDs = ds.documents.map((ds) => ds.data).toList();
      return CDAppPillModel.fromListSnapshot(listDs);
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<CDAppPillModel> getPill({String uid, String pillName}) async {
    try {
      final ds = await Firestore.instance
          .collection(CSDbRoutes.PRESCRIPTIONS)
          .document(uid)
          .collection(CSDbPillDoc.PATH)
          .document(pillName)
          .get();
      return CDAppPillModel.fromSnapshot(ds.data);
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<bool> deletePill({
    @required String uid,
    @required String pillName,
  }) async {
    try {
      await Firestore.instance
          .collection(CSDbRoutes.PRESCRIPTIONS)
          .document(uid)
          .collection(CSDbPillDoc.PATH)
          .document(pillName)
          .delete();
      return true;
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
