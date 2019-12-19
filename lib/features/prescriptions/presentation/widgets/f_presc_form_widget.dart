import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FPrescFormWidget extends StatefulWidget {
  FPrescFormWidget({Key key}) : super(key: key);

  @override
  _FPrescFormWidgetState createState() => _FPrescFormWidgetState();
}

class _FPrescFormWidgetState extends State<FPrescFormWidget> {
  FormBuilderTextField pillName = FormBuilderTextField(
    attribute: "pillName",
    maxLength: 25,
    decoration: InputDecoration(
      labelText: "Prescription name",
      fillColor: Colors.white,
    ),
    validators: [
      FormBuilderValidators.required(),
    ],
  );
  FormBuilderTextField total = FormBuilderTextField(
    attribute: "total",
    decoration: InputDecoration(
      labelText: "Total of prescription",
      fillColor: Colors.white,
    ),
    validators: [
      FormBuilderValidators.required(),
      FormBuilderValidators.numeric(
        errorText: "Must be a numeric value",
      ),
    ],
  );
  FormBuilderTextField current = FormBuilderTextField(
    attribute: "current",
    decoration: InputDecoration(
      labelText: "Actually have",
      fillColor: Colors.white,
    ),
    validators: [
      FormBuilderValidators.required(),
      FormBuilderValidators.numeric(
        errorText: "Must be a numeric value",
      ),
    ],
  );

  FormBuilderTextField qtyToTake = FormBuilderTextField(
    attribute: "qtyToTake",
    decoration: InputDecoration(
      labelText: "Qty to take",
      fillColor: Colors.white,
    ),
    validators: [
      FormBuilderValidators.required(),
      FormBuilderValidators.numeric(
        errorText: "Must be a numeric value",
      ),
    ],
  );
  FormBuilderTextField remindAt = FormBuilderTextField(
    attribute: "remindAt",
    decoration: InputDecoration(
      labelText: "Remind me at X number",
      fillColor: Colors.white,
    ),
    validators: [
      FormBuilderValidators.required(),
      FormBuilderValidators.numeric(
        errorText: "Must be a numeric value",
      ),
    ],
  );
  FormBuilderDateTimePicker remindWhen = FormBuilderDateTimePicker(
    attribute: "reminWhen",
    decoration: InputDecoration(
      labelText: "Remind me when time is",
      fillColor: Colors.white,
    ),
    inputType: InputType.time,
    validators: [
      FormBuilderValidators.required(),
    ],
  );

  Widget _buildPillNameForm() {
    return pillName;
  }

  Widget _buildTotalForm() {
    return total;
  }

  Widget _buildCurrentForm() {
    return current;
  }

  Widget _buildQtyToTakeForm() {
    return qtyToTake;
  }

  Widget _buildRemindMeAtForm() {
    return remindAt;
  }

  Widget _buildRemindMeWhenForm() {
    return remindWhen;
  }

  FormBuilder _formBuilder(BuildContext context) {
    return FormBuilder(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPillNameForm(),
          _buildTotalForm(),
          _buildCurrentForm(),
          _buildQtyToTakeForm(),
          _buildRemindMeAtForm(),
          _buildRemindMeWhenForm(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 1,
          color: Colors.grey,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        ),
        SizedBox(
          height: 40,
        ),
        _formBuilder(context),
      ],
    );
  }
}
