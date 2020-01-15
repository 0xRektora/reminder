import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/bloc/app_bloc.dart';
import '../../../../core/bloc/app_state.dart';
import '../../../../core/static/c_s_styles.dart';
import '../../domain/entities/f_pill_entity.dart';
import '../bloc/prescriptions_bloc.dart';
import '../bloc/prescriptions_event.dart';

// class FPrescFormWidget extends StatefulWidget {
//   final FPPillEntity pillEntity;
//   final String title;

//   FPrescFormWidget({Key key, @required this.title, this.pillEntity})
//       : super(key: key);

//   @override
//   _FPrescFormWidgetState createState() => _FPrescFormWidgetState();
// }

class FPrescFormWidgetState {
  final FPPillEntity pillEntity;
  final String title;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  FormBuilderTextField pillName;

  FormBuilderTextField total;

  FormBuilderTextField current;

  FormBuilderTextField qtyToTake;

  FormBuilderTextField remindAt;

  FormBuilderDateTimePicker remindWhen;

  FPrescFormWidgetState({
    @required this.title,
    this.pillEntity,
  }) {
    _initFormBuilder();
  }

  /// Confirm dialaog to add new presc
  /// Add a new event to the feature bloc
  Future<void> _confirmDialog(
    BuildContext context,
    String pillName,
    int total,
    int current,
    int qtyToTake,
    int remindAt,
    DateTime remindWhen,
  ) async {
    final FPPillEntity entity = FPPillEntity(
      pillName: pillName,
      total: total,
      current: current,
      qtyToTake: qtyToTake,
      remindAt: remindAt,
      remindWhen: remindWhen,
      taken: false,
    );
    final appState = BlocProvider.of<AppBloc>(context).state;
    if (appState is AppLoggedState) {
      final uid = appState.user.uid;
      BlocProvider.of<PrescriptionsBloc>(context)
          .add(FPrescAddPillEvent(pillEntity: entity, uid: uid));
    }
  }

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
  }

  Future<bool> _confirmForm(BuildContext context) async {
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
      await _confirmDialog(context, pillNameValue, totalValue, currentValue,
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

  List<DialogButton> _actionDialog(BuildContext context) {
    return [
      DialogButton(
        onPressed: () {
          _confirmForm(context).then((success) {
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
        this.pillEntity == null ? "" : this.pillEntity.pillName ?? "";
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
        this.pillEntity == null ? "" : "${this.pillEntity.total}" ?? "";
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
        this.pillEntity == null ? "" : "${this.pillEntity.current}" ?? "";
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
        this.pillEntity == null ? "" : "${this.pillEntity.qtyToTake}" ?? "";
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
        this.pillEntity == null ? "" : "${this.pillEntity.remindAt}" ?? "";
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

    final DateTime remindWhenInitValue = this.pillEntity == null
        ? DateTime.now()
        : this.pillEntity.remindWhen ?? DateTime.now();
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

  /// Function that show an alert with the content
  /// provided as params
  Future<bool> showAlert(
    BuildContext context,
    String title,
  ) {
    return Alert(
      style: CSFPresc.alertStyle,
      title: title,
      type: AlertType.none,
      context: context,
      content: _formWidget(context),
      buttons: _actionDialog(context),
    ).show();
  }
}
