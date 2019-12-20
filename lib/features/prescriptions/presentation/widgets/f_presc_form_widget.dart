import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../../core/static/c_s_styles.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FPrescFormWidget extends StatefulWidget {
  final Function confirmCallBack;
  FPrescFormWidget(this.confirmCallBack, {Key key}) : super(key: key);

  @override
  _FPrescFormWidgetState createState() => _FPrescFormWidgetState();
}

class _FPrescFormWidgetState extends State<FPrescFormWidget> {
  var _alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    descStyle: TextStyle(fontWeight: FontWeight.w200, fontSize: 6),
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    titleStyle: TextStyle(
      color: CSAppColors.PRIMARY_COLOR,
    ),
  );

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

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
    keyboardType: TextInputType.number,
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
    keyboardType: TextInputType.number,
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
    keyboardType: TextInputType.number,
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
    keyboardType: TextInputType.number,
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
    keyboardType: TextInputType.datetime,
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

  FormBuilder _buildForm(BuildContext context) {
    return FormBuilder(
      key: _fbKey,
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
    ;
  }

  void _confirmForm(Function callBack) {
    if (_fbKey.currentState.saveAndValidate()) {
      print("validated");
    }
  }

  Column _formWidget(BuildContext context) {
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
        _buildForm(context),
      ],
    );
  }

  List<DialogButton> _actionDialog(BuildContext context) {
    return [
      DialogButton(
        onPressed: () => _confirmForm(widget.confirmCallBack),
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white),
        ),
        color: CSAppColors.PRIMARY_COLOR,
      ),
      DialogButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.red,
      ),
    ];
  }

  Future<bool> _showAlert(BuildContext context) {
    return Alert(
      style: _alertStyle,
      title: "New prescription",
      type: AlertType.none,
      context: context,
      content: _formWidget(context),
      buttons: _actionDialog(context),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20.0,
      right: 20.0,
      child: MaterialButton(
        height: 60.0,
        onPressed: () => _showAlert(context),
        color: Colors.blue,
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
