import 'dart:convert';

import 'package:dartz/dartz_unsafe.dart';

class PackPayload {
  static String call(Map<String, dynamic> data) {
    return jsonEncode(data);
  }
}

class UnpackPayload {
  static Map<String, dynamic> call(String payload) {
    return jsonDecode(payload);
  }
}
