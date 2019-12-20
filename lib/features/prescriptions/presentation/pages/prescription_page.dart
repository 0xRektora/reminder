import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/app_bloc.dart';
import '../../../../core/bloc/bloc.dart';
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
    final appState = BlocProvider.of<AppBloc>(context).state;
    if (appState is AppLoggedState) {
      final uid = appState.user.uid;
      BlocProvider.of<PrescriptionsBloc>(context)
          .add(FPrescAddPillEvent(pillEntity: entity, uid: uid));
    }
  }

  Container _buildPage(BuildContext context, List<Widget> widgets) {
    return Container(
      child: Stack(
        children: <Widget>[
          FPrescFormWidget(_confirmDialog),
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
