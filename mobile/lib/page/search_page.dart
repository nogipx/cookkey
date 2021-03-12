import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 40,
        itemBuilder: (context, index) {
          return Card(child: Text("Index $index"));
        },
      ),
    );
  }
}
