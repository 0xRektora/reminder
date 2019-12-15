import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dependency_injector.dart';
import '../bloc/bloc.dart';
import '../widgets/w_login_with_google.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Scaffold _buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: BlocProvider<LoginBloc>(
        create: (_) => sl<LoginBloc>(),
        child: Center(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }
}
