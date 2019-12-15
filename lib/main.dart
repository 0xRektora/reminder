import 'package:flutter/material.dart';
import 'package:reminder/core/app.dart';
import 'dependency_injector.dart' as di;

void main() async {
  await di.init();
  runApp(MyApp());
}
