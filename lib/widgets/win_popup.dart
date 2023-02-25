import 'package:flutter/material.dart';
import 'package:minesweeper/controller/game_controller.dart';

userHasWonPopup(BuildContext context, {required GameController controller}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text(
        "Congratulations!",
      ),
      content: const Text("You have won the game"),
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
