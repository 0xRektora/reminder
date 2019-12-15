import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';

class WLoginWithGoogle extends StatefulWidget {
  WLoginWithGoogle({Key key}) : super(key: key);

  @override
  _WLoginWithGoogleState createState() => _WLoginWithGoogleState();
}

class _WLoginWithGoogleState extends State<WLoginWithGoogle> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.blue,
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(LoadLoginUserEvent());
      },
      child: Text(
        "Login with Google",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
