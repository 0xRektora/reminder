import 'package:flutter/material.dart';
import 'package:reminder/features/calendar/presentation/pages/calendar.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calendar(),
    );
  }
}
