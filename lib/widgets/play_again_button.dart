import 'package:flutter/material.dart';

import '../controller/game_controller.dart';
import '../helper/audio_player.dart';
import '../utils/exports.dart';
import 'custom_button.dart';

class PlayAgainButton extends StatelessWidget {
  final GameController controller;
  final bool userWon;
  const PlayAgainButton(
      {super.key, required this.controller, required this.userWon});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: userWon ? GameStrings.playAgain : GameStrings.tryAgain,
      onPressed: () {
        Navigator.pop(context);
        controller.createNewGame();
        GameAudioPlayer.resetPlayer(controller.volumeOn);
      },
      icon: Icons.refresh,
      textColor: Colors.white,
      iconSize: GameSizes.getWidth(0.08),
      color: GameColors.popupPlayAgainButton,
      padding: GameSizes.getSymmetricPadding(0.05, 0.015),
    );
  }
}
