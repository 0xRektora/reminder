import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../../../core/static/c_s_styles.dart';

class FPrescFormWidget extends StatefulWidget {
  FPrescFormWidget({Key key}) : super(key: key);

  @override
  _FPrescFormWidgetState createState() => _FPrescFormWidgetState();
}

class _FPrescFormWidgetState extends State<FPrescFormWidget> {
  TextFormField pillName = TextFormField();
  TextFormField total = TextFormField();
  TextFormField current = TextFormField();
  TextFormField qtyToTake = TextFormField();
  TextFormField remindAt = TextFormField();
  TextFormField remindWhen = TextFormField();
  TextEditingController remindWhenController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _formFields(BuildContext context) {
    remindWhen = TextFormField(
      readOnly: true,
      controller: remindWhenController,
      onTap: () {
        DatePicker.showTimePicker(
          context,
          onConfirm: (date) {
            remindWhenController.text =
                "${date.hour}:${date.minute}:${date.second}";
          },
        );
      },
    );
    return [
      Text("Pill name"),
      pillName,
      Text("Total amount"),
      total,
      Text("Current amount"),
      current,
      Text("Qty to take"),
      qtyToTake,
      Text("Remind me at"),
      remindAt,
      Text("Remind me when"),
      remindWhen,
    ];
  }

  List<Widget> _actionDialog(BuildContext context) {
    return [
      MaterialButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("Ok"),
        color: CSAppColors.PRIMARY_COLOR,
      ),
      MaterialButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("Cancel"),
        color: Colors.red,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: _actionDialog(context),
      content: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _formFields(context),
        ),
      ),
    );
  }
}
