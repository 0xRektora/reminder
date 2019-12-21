import 'package:flutter/material.dart';

class FPrescTileWidget extends StatefulWidget {
  final String title;
  FPrescTileWidget({Key key, this.title}) : super(key: key);

  @override
  _FPrescTileWidgetState createState() => _FPrescTileWidgetState();
}

// TODO Add slidable
class _FPrescTileWidgetState extends State<FPrescTileWidget> {
  final TextStyle _textStyle = TextStyle(fontSize: 21);
  final double _padding = 10.0;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(_padding),
        child: Text(
          widget.title,
          style: _textStyle,
        ),
      ),
    );
  }
}
