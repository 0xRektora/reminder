import 'package:flutter/material.dart';

import '../../domain/entities/f_reminder_presc_presc_notification_entity.dart';

class FRprescTileWidget extends StatefulWidget {
  final FReminderPrescPrescNotificationEntity prescNotificationEntity;
  FRprescTileWidget({
    Key key,
    @required this.prescNotificationEntity,
  }) : super(key: key);

  @override
  _FRprescTileWidgetState createState() => _FRprescTileWidgetState();
}

class _FRprescTileWidgetState extends State<FRprescTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.prescNotificationEntity.notificationName),
        trailing: Text(
            '${widget.prescNotificationEntity.timeToTake.hour}:${widget.prescNotificationEntity.timeToTake.minute}'),
      ),
    );
  }
}
