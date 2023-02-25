import 'dart:io';

import 'package:flutter/material.dart';

exitPopup(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text(
        "Do you want to exit?",
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                exit(0);
              },
              child: const Text("Exit"),
            ),
          ],
        )
      ],
    ),
  );
}
