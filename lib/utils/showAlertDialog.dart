import 'package:flutter/material.dart';

Future<bool> showDialogbox(context, content) async {
  var confirmRes = false;
  await showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('AlertDialog Title'),
      content: Text(
          // 'Already amount for same chiti submitted on same date \n Would you like to continue ?'
          content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cancel');
            confirmRes = false;
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'OK');
            confirmRes = true;
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
  return confirmRes;
}

Future<Widget> showAlertDialogbox(context, content, title) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop(); // To close the dialog box
            },
          ),
        ],
      );
    },
  );
}
