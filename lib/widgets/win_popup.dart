import 'dart:io';
import 'package:flutter/material.dart';
import 'package:minesweeper/controller/game_controller.dart';
import 'package:minesweeper/utils/audio_player.dart';

userHasWonPopup(BuildContext context, {required GameController controller}) {
  const String title = "Congratulations!";
  const String content = "You have won the game";
  const String strPlayAgain = "Play again";
  const String strExit = "Exit";
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text(title),
      content: const Text(content),
      actions: [
        TextButton(
          onPressed: () {
            GameAudioPlayer.pause();
            Navigator.pop(context);
            controller.createNewGame();
          },
          child: const Text(strPlayAgain),
        ),
        TextButton(
          onPressed: () {
            GameAudioPlayer.dispose();
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
