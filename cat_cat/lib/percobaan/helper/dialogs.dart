import 'package:flutter/material.dart';

class Dialogs {
  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          msg,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber.withOpacity(.8),
        behavior: SnackBarBehavior.floating));
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber))));
  }
}
