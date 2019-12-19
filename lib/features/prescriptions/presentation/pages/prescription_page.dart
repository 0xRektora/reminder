import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/core/static/c_s_styles.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../dependency_injector.dart';
import '../../domain/entities/f_pill_entity.dart';
import '../bloc/bloc.dart';
import '../widgets/f_presc_form_widget.dart';

class PrescriptionPage extends StatefulWidget {
  PrescriptionPage({Key key}) : super(key: key);

  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
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
    BlocProvider.of<PrescriptionsBloc>(context)
        .add(FPrescAddPillEvent(pillEntity: entity));
  }

  List<DialogButton> _actionDialog(BuildContext context) {
    return [
      DialogButton(
        onPressed: () {
          Navigator.of(context).pop();
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

  Future<bool> _showAlert(BuildContext context) {
    return Alert(
      style: _alertStyle,
      title: "New prescription",
      type: AlertType.none,
      context: context,
      buttons: _actionDialog(context),
      content: FPrescFormWidget(),
    ).show();
  }

  Widget _buildAddButton(BuildContext context) {
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

  Container _buildPage(BuildContext context, List<Widget> widgets) {
    return Container(
      child: Stack(
        children: <Widget>[
          _buildAddButton(context),
        ]..addAll(widgets),
      ),
    );
  }

  BlocBuilder<PrescriptionsBloc, PrescriptionsState> _blocBuilder(
      BuildContext context) {
    return BlocBuilder<PrescriptionsBloc, PrescriptionsState>(
      builder: (BuildContext context, PrescriptionsState state) {
        if (state is InitialPrescriptionsState)
          return _buildPage(context, []);
        else
          return _buildPage(context, []);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PrescriptionsBloc>(
      create: (_) => sl<PrescriptionsBloc>(),
      child: _blocBuilder(context),
    );
  }
}
