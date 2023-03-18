import 'package:flutter/material.dart';
import 'package:minesweeper/controller/game_controller.dart';

import '../constants/color_consts.dart';
import '../utils/audio_player.dart';

class PlayAgainButton extends StatelessWidget {
  final GameController controller;
  final bool userWon;
  const PlayAgainButton(
      {super.key, required this.controller, this.userWon = true});

  @override
  Widget build(BuildContext context) {
    const String strPlayAgain = "Play Again";
    const String strTryAgain = "Try Again";

    return GestureDetector(
      onTap: () {
        GameAudioPlayer.pause();
        Navigator.pop(context);
        controller.createNewGame();
      },
      child: Container(
        decoration: BoxDecoration(
            color: GameColors.popupPlayAgainButton,
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Icon(
              Icons.refresh,
              color: Colors.white,
              size: 34,
            ),
            const SizedBox(width: 16),
            Text(
              userWon ? strPlayAgain : strTryAgain,
              style: const TextStyle(fontSize: 26, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
