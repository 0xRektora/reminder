import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CSBottomNavBarStyle {
  static final Color iconColor = Colors.black;
  static final Color activeColor = Colors.blueAccent;
  static final TextStyle textStyle =
      TextStyle(color: Colors.black, fontSize: 12.0);
}

class CSAppColors {
  static const PRIMARY_COLOR = Colors.blue;
  static const ACCENT_COLOR = Colors.cyan;
}

class CSAppTheme {
  static final ThemeData theme = ThemeData(
    brightness: Brightness.light,
    primaryColor: CSAppColors.PRIMARY_COLOR,
    accentColor: CSAppColors.ACCENT_COLOR,
  );
}

class CSFPresc {
  static final alertStyle = AlertStyle(
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
}

class CSFCalendar {
  static const Color pillTaken = Colors.green;
  static const Color pillNotTaken = Colors.red;
  static const Color inactiveDay = Colors.grey;
}
