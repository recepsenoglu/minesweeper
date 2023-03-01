import 'dart:io';
import 'package:flutter/material.dart';

exitPopup(BuildContext context) {
  const String title = "Do you want to exit?";
  const String strCancel = "Cancel";
  const String strExit = "Exit";
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(title),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(strCancel),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            exit(0);
          },
          child: const Text(
            strExit,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
