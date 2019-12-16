import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/core/bloc/bloc.dart';

import '../../../../dependency_injector.dart';
import '../bloc/bloc.dart';
import '../widgets/w_login_with_google.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Container _buildPage(BuildContext context) {
    return Container(
      child: BlocProvider<LoginBloc>(
        create: (_) => sl<LoginBloc>(),
        child: Center(
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoadedLoginState)
                BlocProvider.of<AppBloc>(context)
                    .add(AppLoggedEvent(state.user));
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is InitialLoginState)
                  return WLoginWithGoogle();
                else if (state is LoadingLoginState)
                  return CircularProgressIndicator();
                else if (state is ErrorLoginState)
                  return Text(state.message);
                else if (state is LoadedLoginState)
                  return Text("User sign in : " + state.user.toString());
                else
                  return WLoginWithGoogle();
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }
}
