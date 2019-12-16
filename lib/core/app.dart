import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/core/bloc/app_bloc.dart';
import 'package:reminder/core/bloc/app_state.dart';
import 'package:reminder/dependency_injector.dart';
import 'package:reminder/features/login/presentation/pages/login_page.dart';

import '../features/calendar/presentation/pages/calendar_page.dart';
import '../features/prescriptions/presentation/pages/prescription_page.dart';
import '../features/settings/presentation/pages/settings_page.dart';
import 'static/c_s_styles.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: App(),
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
          color: BottomNavBarStyle.iconColor,
        ),
        title: Text(
          "Prescriptions",
          style: BottomNavBarStyle.textStyle,
        ),
        activeColor: BottomNavBarStyle.activeColor),
    // Calendar
    BottomNavyBarItem(
        icon: Icon(
          Icons.calendar_today,
          color: BottomNavBarStyle.iconColor,
        ),
        title: Text(
          "Calendar",
          style: BottomNavBarStyle.textStyle,
        ),
        activeColor: BottomNavBarStyle.activeColor),
    // Settings
    BottomNavyBarItem(
        icon: Icon(
          Icons.settings,
          color: BottomNavBarStyle.iconColor,
        ),
        title: Text(
          "Settings",
          style: BottomNavBarStyle.textStyle,
        ),
        activeColor: BottomNavBarStyle.activeColor),
  ];

  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (_) => sl<AppBloc>(),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state is AppLoggedState)
            return _buildApp(context);
          else
            return _buildLogin(context);
        },
      ),
    );
  }
}
