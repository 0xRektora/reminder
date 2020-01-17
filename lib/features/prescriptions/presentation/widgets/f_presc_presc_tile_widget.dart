import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FPrescTileWidget extends StatefulWidget {
  final String title;
  final Function() onLongPress;
  final Function(String pillName) deleteAction;
  FPrescTileWidget({
    Key key,
    @required this.title,
    @required this.deleteAction,
    @required this.onLongPress,
  }) : super(key: key);

  @override
  _FPrescTileWidgetState createState() => _FPrescTileWidgetState();
}

class _FPrescTileWidgetState extends State<FPrescTileWidget> {
  final TextStyle _textStyle = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.normal,
  );
  final double _padding = 20.0;

  IconSlideAction _deleteAction() {
    return IconSlideAction(
      caption: "Delete",
      color: Colors.red,
      icon: Icons.delete_forever,
      onTap: () {
        widget.deleteAction(widget.title);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Slidable(
        actionExtentRatio: 0.25,
        actionPane: SlidableDrawerActionPane(),
        secondaryActions: <Widget>[
          _deleteAction(),
        ],
        child: FlatButton(
          onLongPress: widget.onLongPress,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(_padding),
            child: Text(
              widget.title,
              style: _textStyle,
            ),
          ),
          onPressed: () {}, // Do nothing
        ),
      ),
    );
  }
}
