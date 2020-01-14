import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dependency_injector.dart';
import '../../domain/entities/f_reminder_presc_presc_notification_entity.dart';
import '../bloc/bloc.dart';
import '../widgets/f_reminder_presc_tile_widget.dart';

class ReminderPrescPage extends StatefulWidget {
  ReminderPrescPage({Key key}) : super(key: key);

  @override
  _ReminderPrescPageState createState() => _ReminderPrescPageState();
}

class _ReminderPrescPageState extends State<ReminderPrescPage> {
  Widget _buildListNotifiction(
    List<FReminderPrescPrescNotificationEntity> listPrescNotificationEntity,
  ) {
    List<FRprescTileWidget> prescTileWidget = [];
    for (var prescNtoficationEntity in listPrescNotificationEntity) {
      prescTileWidget.add(
        FRprescTileWidget(
          prescNotificationEntity: prescNtoficationEntity,
        ),
      );
    }
  }

  Widget _buildPrescPage(
    BuildContext context, {
    List<Widget> listNotification,
  }) {
    return SingleChildScrollView(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return listNotification[index];
        },
        itemCount: listNotification.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.grey,
          );
        },
      ),
    );
  }

  Widget _blocStateBuilder(BuildContext context, ReminderPrescState state) {
    if (state is InitialReminderPrescState) {
      return Container();
    }
    // TODO implemend functuin _buildPrescPage
    if (state is FReminderPrescListState) {}
  }

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
