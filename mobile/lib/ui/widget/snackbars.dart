import 'package:flutter/material.dart';

abstract class AppSnackbar {
  AppSnackbar._();

  static const defaultDuration = Duration(milliseconds: 1000);

  static SnackBar genericSnackBar({
    Text message,
    Icon icon,
    Color backgroundColor,
    bool isLoading = false,
    Duration duration = defaultDuration,
  }) {
    return SnackBar(
      duration: duration,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: message),
          if (isLoading) CircularProgressIndicator() else icon ?? SizedBox(),
        ],
      ),
      backgroundColor: backgroundColor,
    );
  }

  static SnackBar error([String message]) => genericSnackBar(
        message: Text(message),
        icon: Icon(Icons.error),
        backgroundColor: Colors.red,
      );

  static SnackBar info([String message]) => genericSnackBar(
        message: Text(message),
      );

  static SnackBar loading([String message, Duration duration]) => genericSnackBar(
        duration: duration ?? defaultDuration,
        isLoading: true,
        message: Text(message),
      );

  static SnackBar success([String message, Duration duration]) => genericSnackBar(
        message: Text(message),
        icon: Icon(Icons.done),
        backgroundColor: Colors.green,
        duration: duration ?? defaultDuration,
      );
}
