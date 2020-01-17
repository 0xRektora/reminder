import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/bloc/bloc.dart';
import '../../domain/entities/f_reminder_presc_presc_notification_entity.dart';
import '../bloc/bloc.dart';

class FRprescTileWidget extends StatefulWidget {
  final FReminderPrescPrescNotificationEntity prescNotificationEntity;

  static const String titleAlert = "Pill validation";
  static const Text descValidation = Text('Do you want to validate ?');

  FRprescTileWidget({
    Key key,
    @required this.prescNotificationEntity,
  }) : super(key: key);

  @override
  _FRprescTileWidgetState createState() => _FRprescTileWidgetState();
}

class _FRprescTileWidgetState extends State<FRprescTileWidget> {
  _confirmEvent(BuildContext context, String pillName) {
    final state = BlocProvider.of<AppBloc>(context).state;
    if (state is AppLoggedState) {
      final String uid = state.user.uid;
      BlocProvider.of<ReminderPrescBloc>(context).add(
        FReminderPrescValidateEvent(
          pillName: pillName,
          uid: uid,
        ),
      );
    }
  }

  /// Called when user tap a tile
  _onTap(BuildContext context) {
    Alert(
      context: context,
      title: FRprescTileWidget.titleAlert,
      type: AlertType.info,
      content: FRprescTileWidget.descValidation,
      buttons: [
        DialogButton(
          color: Colors.green,
          child: Text(
            "Confirm",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            _confirmEvent(
              context,
              widget.prescNotificationEntity.notificationName,
            );
            Navigator.pop(context);
          },
        ),
        DialogButton(
          color: Colors.red,
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context),
      child: Card(
        child: ListTile(
          title: Text(widget.prescNotificationEntity.notificationName),
          trailing: Text(
              '${widget.prescNotificationEntity.timeToTake.hour}:${widget.prescNotificationEntity.timeToTake.minute}'),
        ),
      ),
    );
  }
}
