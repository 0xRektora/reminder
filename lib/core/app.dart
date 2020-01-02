import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder/core/utils/utils.dart';
import 'package:reminder/features/reminder_schedule/domain/usecases/f_reminder_schedule_unset_usecase.dart';

import '../dependency_injector.dart';
import '../features/calendar/presentation/pages/calendar_page.dart';
import '../features/login/presentation/pages/login_page.dart';
import '../features/prescriptions/presentation/pages/prescription_page.dart';
import '../features/settings/presentation/pages/settings_page.dart';
import 'bloc/bloc.dart';
import 'static/c_s_styles.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  Future<void> _onSelectNotification(String t) {
    print("onSelectNotification" + t);

    return null;
  }

  Future<void> _initLocalNotif() {
    final initializationSettingsAndroid =
        new AndroidInitializationSettings('ic_launcher');
    // IOS not needed
    final initializationSettingsIOS = IOSInitializationSettings();
    final initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (t) => _onSelectNotification(t));
    return null;
  }

  @override
  void initState() {
    super.initState();
    _flutterLocalNotificationsPlugin = sl<FlutterLocalNotificationsPlugin>();
    _initLocalNotif();
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
  int _selectedItem = 0;
  int last_page = 0;
  PageController _pageController = PageController();

  final List<Widget> pageViews = <Widget>[
    PrescriptionPage(),
    CalendarPage(),
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
      //TODO change bottom nav bar
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
