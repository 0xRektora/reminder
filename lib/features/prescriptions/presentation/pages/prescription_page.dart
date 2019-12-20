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

  Container _buildPage(BuildContext context, List<Widget> widgets) {
    return Container(
      child: Stack(
        children: <Widget>[
          FPrescFormWidget(() {
            print("validate");
          }),
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
