import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class ErrorAlertDialog extends StatelessWidget {
  final String message;
  const ErrorAlertDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          // color: Colors.red,
          child: Center(
            child: Text("OK"),
          ),
        )
      ],
    );
  }
}
