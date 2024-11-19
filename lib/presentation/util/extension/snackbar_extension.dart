import 'package:flutter/material.dart';
import 'package:images/presentation/util/globals.dart';

extension SnackbarExtension on String {
  void showMessage() {
    scaffoldMessengerKey.currentState!.clearSnackBars();
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(this),
      ),
    );
  }
}
