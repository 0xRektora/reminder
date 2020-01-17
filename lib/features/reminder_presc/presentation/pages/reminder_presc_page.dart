import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/bloc.dart';
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
  /// Used for [_buildPrescPage]
  ///
  /// Takes a list of [FReminderPrescPrescNotificationEntity]
  List<FRprescTileWidget> _buildListNotifiction(
    BuildContext context,
    List<FReminderPrescPrescNotificationEntity> listPrescNotificationEntity,
  ) {
    List<FRprescTileWidget> prescTileWidget = [];
    for (FReminderPrescPrescNotificationEntity prescNtoficationEntity
        in listPrescNotificationEntity) {
      prescTileWidget.add(
        FRprescTileWidget(
          prescNotificationEntity: prescNtoficationEntity,
        ),
      );
    }
    return prescTileWidget;
  }

  /// Builder for the main page content
  Widget _buildPrescPage(
    BuildContext context, {
    List<FRprescTileWidget> listNotification,
  }) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return listNotification[index];
      },
      itemCount: listNotification.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 5,
        );
      },
    );
  }

  Widget _blocStateBuilder(BuildContext context, ReminderPrescState state) {
    if (state is InitialReminderPrescState) {
      final state = BlocProvider.of<AppBloc>(context).state;
      if (state is AppLoggedState) {
        BlocProvider.of<ReminderPrescBloc>(context).add(
          FReminderPrescListEvent(uid: state.user.uid),
        );
        return Container();
      }
    } else if (state is FReminderPrescListState) {
      if (state.prescNotificationEntity.length == 0) {
        return Container();
      } else {
        return _buildPrescPage(
          context,
          listNotification: _buildListNotifiction(
            context,
            state.prescNotificationEntity,
          ),
        );
      }
    } else {
      return Container();
    }
  }

  void _blocListener(BuildContext context, ReminderPrescState state) {
    if (state is FReminderPrescValidateState) {
      BlocProvider.of<ReminderPrescBloc>(context).add(
        FReminderPrescListEvent(uid: state.uid),
      );
    }
  }

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
