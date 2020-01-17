import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../dependency_injector.dart';
import '../features/calendar/presentation/pages/calendar_page.dart';
import '../features/login/presentation/pages/login_page.dart';
import '../features/prescriptions/presentation/pages/prescription_page.dart';
import '../features/reminder_presc/presentation/pages/reminder_presc_page.dart';
import '../features/settings/presentation/pages/settings_page.dart';
import 'bloc/bloc.dart';
import 'static/c_s_styles.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (_) => sl<AppBloc>(),
      child: MaterialApp(
        home: App(),
        theme: CSAppTheme.theme,
      ),
    );
  }
}

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  static const animationSpeed = Duration(milliseconds: 500);
  static const reminderPrescPagePlace = 2;

  int _selectedItem = 0;

  PageController _pageController = PageController();

  final List<Widget> pageViews = <Widget>[
    PrescriptionPage(),
    CalendarPage(),
    ReminderPrescPage(),
    SettingsPage(),
  ];

  final bottomNavBarItems = [
    // Prescription
    BottomNavyBarItem(
        icon: Icon(
          Icons.add_alert,
          color: CSBottomNavBarStyle.iconColor,
        ),
        title: Text(
          "Prescriptions",
          style: CSBottomNavBarStyle.textStyle,
        ),
        activeColor: CSBottomNavBarStyle.activeColor),
    // Calendar
    BottomNavyBarItem(
        icon: Icon(
          Icons.calendar_today,
          color: CSBottomNavBarStyle.iconColor,
        ),
        title: Text(
          "Calendar",
          style: CSBottomNavBarStyle.textStyle,
        ),
        activeColor: CSBottomNavBarStyle.activeColor),
    // Reminder Presc
    BottomNavyBarItem(
        icon: Icon(
          Icons.alarm,
          color: CSBottomNavBarStyle.iconColor,
        ),
        title: Text(
          "Reminder",
          style: CSBottomNavBarStyle.textStyle,
        ),
        activeColor: CSBottomNavBarStyle.activeColor),
    // Settings
    BottomNavyBarItem(
        icon: Icon(
          Icons.settings,
          color: CSBottomNavBarStyle.iconColor,
        ),
        title: Text(
          "Settings",
          style: CSBottomNavBarStyle.textStyle,
        ),
        activeColor: CSBottomNavBarStyle.activeColor),
  ];

  Future<void> _onSelectNotification() {
    _pageController.animateToPage(
      _AppState.reminderPrescPagePlace,
      duration: _AppState.animationSpeed,
      curve: Curves.linear,
    );
    return null;
  }

  Future<void> _initLocalNotif({
    @required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) {
    final initializationSettingsAndroid =
        new AndroidInitializationSettings('ic_launcher');
    // IOS not needed
    final initializationSettingsIOS = IOSInitializationSettings();
    final initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (_) => _onSelectNotification());
    return null;
  }

  Scaffold _buildApp(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reminder"),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (currentPage) {
          setState(() {
            _selectedItem = currentPage;
          });
        },
        children: pageViews,
      ),
      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        selectedIndex: _selectedItem,
        onItemSelected: (index) => setState(() {
          _selectedItem = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        }),
        items: bottomNavBarItems,
      ),
    );
  }

  Scaffold _buildLogin(BuildContext context) {
    return Scaffold(
      body: LoginPage(),
    );
  }

  @override
  void initState() {
    super.initState();
    _initLocalNotif(
      flutterLocalNotificationsPlugin: sl<FlutterLocalNotificationsPlugin>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is AppLoggedState)
          return _buildApp(context);
        else if (state is CAppLoadingLoginState)
          return Container(color: CSAppColors.PRIMARY_COLOR);
        else
          return _buildLogin(context);
      },
    );
  }
}
