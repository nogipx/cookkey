import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'export.dart';

class RequestBuilder<Value, Error>
    extends BlocBuilderBase<RequestCubit<Value, Error>, RequestState<Value>> {
  @override
  final Widget Function(BuildContext context, RequestState<Value> state) builder;
  final Widget Function(BuildContext context, RequestInitial<Value> state) onInitial;
  final Widget Function(BuildContext context, RequestSuccess<Value> state) onSuccess;
  final Widget Function(BuildContext context) defaultBuilder;
  final Widget Function(BuildContext context, RequestInProgress<Value> state)
      onInProgress;
  final Widget Function(BuildContext context, RequestFailure<Value, Error> state)
      onFailure;

  const RequestBuilder({
    Key key,
    @required RequestCubit<Value, Error> cubit,
    this.builder,
    this.onInitial,
    this.onSuccess,
    this.onInProgress,
    this.onFailure,
    this.defaultBuilder,
    BlocBuilderCondition<RequestState<Value>> buildWhen,
  }) : super(
          key: key,
          cubit: cubit,
          buildWhen: buildWhen,
        );

  @override
  Widget build(BuildContext context, RequestState<Value> state) {
    if (builder != null) {
      return builder(context, state);
    } else if (state is RequestInitial<Value> && onInitial != null) {
      return onInitial(context, state);
    } else if (state is RequestSuccess<Value> && onSuccess != null) {
      return onSuccess(context, state);
    } else if (state is RequestInProgress<Value> && onInProgress != null) {
      return onInProgress(context, state);
    } else if (state is RequestFailure<Value, Error> && onFailure != null) {
      return onFailure(context, state);
    } else if (defaultBuilder != null) {
      return defaultBuilder(context);
    } else {
      throw "No builder provided.";
    }
  }
}
