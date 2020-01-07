import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/features/reminder_presc/presentation/bloc/bloc.dart';

import '../../../../dependency_injector.dart';

class ReminderPrescPage extends StatefulWidget {
  ReminderPrescPage({Key key}) : super(key: key);

  @override
  _ReminderPrescPageState createState() => _ReminderPrescPageState();
}

class _ReminderPrescPageState extends State<ReminderPrescPage> {
  void _blocStateBuilder(BuildContext context, ReminderPrescState state) {}

  void _blocListener(BuildContext context, ReminderPrescState state) {}

  Widget _blocBuilder(BuildContext context) {
    return BlocListener<ReminderPrescBloc, ReminderPrescState>(
      listener: _blocListener,
      child: BlocBuilder<ReminderPrescBloc, ReminderPrescState>(
        builder: _blocStateBuilder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReminderPrescBloc>(
      create: (_) => sl<ReminderPrescBloc>(),
      child: _blocBuilder(context),
    );
  }
}
