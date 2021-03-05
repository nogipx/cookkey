import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';

import '../convenient_bloc.dart';

class ConvenientBlocObserver extends BlocObserver {
  static List<String> eventNameColor;
  static List<String> eventTextColor = [ansiCyan];
  static List<String> errorNameColor = [];
  static List<String> errorTextColor = [];
  static List<String> transitionNameColor = [];
  static List<String> transitionTextColor = [];

  @override
  void onEvent(Bloc bloc, Object event) {
    developer.log(
      event.toString().color(eventTextColor ?? [ansiCyan]),
      name: bloc.runtimeType.toString().color(eventNameColor ?? [ansiPurple, ansiBold]),
    );
    super.onEvent(bloc, event);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    developer.log(
      error.toString().color(errorTextColor ?? [ansiRedBg, ansiDarkWhite]),
      name: cubit.runtimeType.toString().color(errorNameColor ?? [ansiDarkGray, ansiDarkBlueBg]),
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    developer.log(
      transition.toString().color(eventTextColor ?? [ansiCyan]),
      name: bloc.runtimeType.toString().color(eventNameColor ?? [ansiPurple, ansiBold]),
    );
    super.onTransition(bloc, transition);
  }
}
