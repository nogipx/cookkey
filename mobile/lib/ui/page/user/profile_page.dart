import 'package:cookkey/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final AuthBloc authBloc;

  const ProfilePage({Key key, @required this.authBloc}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              widget.authBloc.logout();
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(child: Text("Index $index"));
        },
      ),
    );
  }
}
