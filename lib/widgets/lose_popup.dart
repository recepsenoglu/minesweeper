import 'package:flutter/material.dart';
import 'package:minesweeper/constants/color_consts.dart';
import 'package:minesweeper/constants/image_enums.dart';
import 'package:minesweeper/widgets/play_again_button.dart';
import '../controller/game_controller.dart';

showLoseScreen(BuildContext context, {required GameController controller}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 280,
            decoration: BoxDecoration(
                color: GameColors.popupBackground,
                borderRadius: BorderRadius.circular(16)),
            child: Stack(
              children: [
                Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(Images.loseScreen.toPath))),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 72,
                                child: Image.asset(Images.stopwatch.toPath)),
                            const SizedBox(height: 10),
                            const Text(
                              "---",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 36),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                                height: 72,
                                child: Image.asset(Images.trophy.toPath)),
                            const SizedBox(height: 10),
                            const Text(
                              "---",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 36),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          PlayAgainButton(controller: controller, userWon: false),
        ],
      ),
    ),
  );
}
