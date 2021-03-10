import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DependencyInjector extends StatefulWidget {
  final Widget child;

  const DependencyInjector({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  _DependencyInjectorState createState() => _DependencyInjectorState();
}

class _DependencyInjectorState extends State<DependencyInjector> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [],
      child: widget.child,
    );
  }
}
