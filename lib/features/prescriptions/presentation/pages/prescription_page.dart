import 'package:flutter/material.dart';
import 'package:reminder/core/static/c_s_styles.dart';

class PrescriptionPage extends StatefulWidget {
  PrescriptionPage({Key key}) : super(key: key);

  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Text("hello"),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: MaterialButton(
              height: 60.0,
              onPressed: () {},
              color: Colors.blue,
              shape: CircleBorder(),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
