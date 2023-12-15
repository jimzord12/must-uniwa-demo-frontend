import 'package:flutter/material.dart';

void showWaitForTransactionDialog(
    {required BuildContext context,
    required String title,
    required String content}) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents closing on tap outside
    builder: (BuildContext context) {
      return PopScope(
        canPop: false, // Prevents closing on back button
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Text(content),
                const SizedBox(height: 20),
                const CircularProgressIndicator(), // Circular Loading Indicator
              ],
            ),
          ),
        ),
      );
    },
  );
}
