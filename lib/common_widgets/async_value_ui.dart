import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/utils/app_styles.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

extension AsyncValueUi on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      final message = _errorMessage(error);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                icon: const Icon(Icons.error, color: Colors.red, size: 40),
                title: Text(message, style: AppStyles.normalTextStyle),
                actions: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Close", style: AppStyles.normalTextStyle)),
                  ])
                ],
              ));
    }
  }
}

String _errorMessage(Object? error) {
  if (error is FirebaseException) {
    return error.message ?? error.toString();
  } else if (error is Exception) {
    return error.toString();
  } else {
    return error.toString();
  }
}
