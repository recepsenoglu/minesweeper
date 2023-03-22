import 'package:flutter/material.dart';

import '../constants/color_consts.dart';
import '../controller/game_controller.dart';
import '../utils/audio_player.dart';

class PlayAgainButton extends StatelessWidget {
  final GameController controller;
  final bool userWon;
  const PlayAgainButton(
      {super.key, required this.controller, required this.userWon});

  @override
  Widget build(BuildContext context) {
    const String strPlayAgain = "Play Again";
    const String strTryAgain = "Try Again";

    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pop(context);
        GameAudioPlayer.resetPlayer();
        controller.createNewGame();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: GameColors.popupPlayAgainButton,
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      icon: const Icon(
        Icons.refresh,
        color: Colors.white,
        size: 34,
      ),
      label: Text(
        userWon ? strPlayAgain : strTryAgain,
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}
