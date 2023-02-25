import 'package:flutter/material.dart';

import '../controller/game_controller.dart';

userLosePopup(BuildContext context, {required GameController controller}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text(
        "You lost!",
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                controller.createNewGame();
              },
              child: const Text("Play Again"),
            ),
          ],
        )
      ],
    ),
  );
}
