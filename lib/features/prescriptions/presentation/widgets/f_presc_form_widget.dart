import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:reminder/core/static/c_s_styles.dart';
import 'package:reminder/core/utils/c_app_converter.dart';
import 'package:reminder/features/prescriptions/domain/entities/f_pill_entity.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FPrescFormWidget extends StatefulWidget {
  _FPrescFormWidgetState _state = _FPrescFormWidgetState();
  final FPPillEntity pillEntity;

  FPrescFormWidget({Key key, this.pillEntity}) : super(key: key);

  List<DialogButton> actionDialog(
      BuildContext context,
      Function(
    BuildContext context,
    String pillName,
    int total,
    int current,
    int qtyToTake,
    int remindAt,
    DateTime remindWhen,
  )
          confirmCallBack) {
    return _state.actionDialog(context, confirmCallBack);
  }

  @override
  _FPrescFormWidgetState createState() {
    _state = _FPrescFormWidgetState();
    return _state;
  }
}

class _FPrescFormWidgetState extends State<FPrescFormWidget> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  FormBuilderTextField pillName;

  FormBuilderTextField total;

  FormBuilderTextField current;

  FormBuilderTextField qtyToTake;

  FormBuilderTextField remindAt;

  FormBuilderDateTimePicker remindWhen;

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

  Future<bool> _confirmForm(context, Function callBack) async {
    print("KEY: " + _fbKey.currentState.toString());
    if (_fbKey.currentState.saveAndValidate()) {
      final pillNameValue =
          _fbKey.currentState.fields["pillName"].currentState.value;
      final totalValue =
          int.parse(_fbKey.currentState.fields["total"].currentState.value);
      final currentValue =
          int.parse(_fbKey.currentState.fields["current"].currentState.value);
      final qtyToTakeValue =
          int.parse(_fbKey.currentState.fields["qtyToTake"].currentState.value);
      final remindAtValue =
          int.parse(_fbKey.currentState.fields["remindAt"].currentState.value);
      final remindWhenValue =
          _fbKey.currentState.fields["remindWhen"].currentState.value;
      await callBack(context, pillNameValue, totalValue, currentValue,
          qtyToTakeValue, remindAtValue, remindWhenValue);
      return true;
    } else {
      return false;
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

  List<DialogButton> actionDialog(BuildContext context, confirmCallBack) {
    return [
      DialogButton(
        onPressed: () {
          _confirmForm(context, confirmCallBack).then((success) {
            if (success) {
              Navigator.of(context).pop();
            }
          });
        },
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

  void _initFormBuilder() {
    final String pillNameInitValue =
        widget.pillEntity == null ? "" : widget.pillEntity.pillName ?? "";
    pillName = FormBuilderTextField(
      attribute: "pillName",
      initialValue: pillNameInitValue,
      maxLength: 25,
      decoration: InputDecoration(
        labelText: "Prescription name",
        fillColor: Colors.white,
      ),
      validators: [
        FormBuilderValidators.required(),
      ],
    );

    final String totalInitValue =
        widget.pillEntity == null ? "" : "${widget.pillEntity.total}" ?? "";
    total = FormBuilderTextField(
      attribute: "total",
      initialValue: totalInitValue,
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

    final String currentInitValue =
        widget.pillEntity == null ? "" : "${widget.pillEntity.current}" ?? "";
    current = FormBuilderTextField(
      attribute: "current",
      initialValue: currentInitValue,
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

    final String qtyToTakeInitValue =
        widget.pillEntity == null ? "" : "${widget.pillEntity.qtyToTake}" ?? "";
    qtyToTake = FormBuilderTextField(
      attribute: "qtyToTake",
      initialValue: qtyToTakeInitValue,
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

    final String remindAtInitValue =
        widget.pillEntity == null ? "" : "${widget.pillEntity.remindAt}" ?? "";
    remindAt = FormBuilderTextField(
      attribute: "remindAt",
      initialValue: remindAtInitValue,
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

    final DateTime remindWhenInitValue = widget.pillEntity == null
        ? DateTime.now()
        : widget.pillEntity.remindWhen ?? DateTime.now();
    remindWhen = FormBuilderDateTimePicker(
      attribute: "remindWhen",
      keyboardType: TextInputType.datetime,
      initialValue: remindWhenInitValue,
      format: DateFormat("hh:mm a"),
      decoration: InputDecoration(
        labelText: "Remind me when time is",
        fillColor: Colors.white,
      ),
      inputType: InputType.time,
      validators: [
        FormBuilderValidators.required(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _initFormBuilder();
  }

  @override
  Widget build(BuildContext context) {
    return _formWidget(context);
  }
}
