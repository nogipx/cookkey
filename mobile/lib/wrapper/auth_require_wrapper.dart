import 'package:cookkey/bloc/auth_bloc.dart';
import 'package:cookkey/page/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_manager/navigation_manager.dart';

class AuthRequireWrapper extends StatelessWidget {
  final Widget child;
  final AppRoute currentRoute;
  final List<AppRoute> authRoutes;

  const AuthRequireWrapper({
    Key key,
    @required this.child,
    @required this.currentRoute,
    @required this.authRoutes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (authRoutes.contains(currentRoute) && state is! AuthSuccessLogin) {
          return LoginPage(
            authBloc: context.watch<AuthBloc>(),
          );
        } else {
          return child;
        }
      },
    );
  }
}
