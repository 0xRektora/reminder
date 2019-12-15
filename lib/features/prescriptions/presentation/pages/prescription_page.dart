import 'package:flutter/material.dart';

class PrescriptionPage extends StatefulWidget {
  PrescriptionPage({Key key}) : super(key: key);

  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Prescriptions"),
      ),
    );
  }
}
