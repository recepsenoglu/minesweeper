import 'package:flutter/material.dart';

import '../constants/color_consts.dart';
import '../controller/game_controller.dart';

class SkipButton extends StatelessWidget {
  final GameController gameController;
  const SkipButton({super.key, required this.gameController});

  @override
  Widget build(BuildContext context) {
    if (!gameController.isMineAnimationOn) {
      return const SizedBox();
    }

    return Positioned(
      bottom: 120,
      child: ElevatedButton.icon(
        onPressed: () {
          gameController.minesAnimation = false;
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 14.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          backgroundColor: GameColors.skipButton,
        ),
        icon: const Icon(Icons.fast_forward_sharp, size: 28),
        label: const Text("Skip", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
