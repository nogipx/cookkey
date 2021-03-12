import 'dart:async';

import 'package:cookkey/bloc/auth_bloc.dart';
import 'package:cookkey/bloc/scaffold_feedback.dart';
import 'package:cookkey/widget/password_field.dart';
import 'package:cookkey/widget/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final AuthBloc authBloc;

  const LoginPage({
    Key key,
    @required this.authBloc,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey();
  TextEditingController _username;
  TextEditingController _password;
  StreamSubscription _feedback;
  FeedbackBloc _feedbackBloc;

  @override
  void initState() {
    _username = TextEditingController();
    _password = TextEditingController();
    _feedbackBloc = context.read<FeedbackBloc>();
    _feedback = widget.authBloc.listen((state) {
      if (state is AuthFailure) {
        _feedbackBloc.push<LoginPage>(state.error.message);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _feedback.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login page"),
              TextFormField(
                controller: _username,
              ),
              PasswordInputField(
                controller: _password,
                decoration: InputDecoration(),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  widget.authBloc.loginPassword(_username.text, _password.text);
                },
                icon: Icon(Icons.login),
                label: Text("Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
