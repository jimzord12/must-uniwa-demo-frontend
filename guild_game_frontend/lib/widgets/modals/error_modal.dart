import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(errorMessage),
        backgroundColor: Colors.red.shade700, // Set the background color here
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Close'),
            onPressed: () {
              if (errorMessage ==
                      "Something went wrong with the Server. Please try again later." ||
                  errorMessage.contains('PDF file Duplicate Name!')) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
