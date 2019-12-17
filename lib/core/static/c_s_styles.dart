import 'package:flutter/material.dart';

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
