import 'package:flutter/material.dart';

import '../constants/color_consts.dart';
import '../constants/image_enums.dart';
import '../controller/game_controller.dart';
import '../view/home_view/home_view.dart';
import 'play_again_button.dart';

class GamePopupScreen {
  GamePopupScreen(_);

  static Future<void> gameOver(
    BuildContext context, {
    required GameController controller,
    required int? bestTime,
    required bool win,
  }) async {
    String time = win
        ? "0" * (3 - controller.timeElapsed.toString().length) +
            controller.timeElapsed.toString()
        : "---";

    String record = bestTime != null
        ? "0" * (3 - bestTime.toString().length) + bestTime.toString()
        : "---";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          child: Image.asset(win
                              ? Images.winScreen.toPath
                              : Images.loseScreen.toPath))),
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
                              Text(
                                time,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 36),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                  height: 72,
                                  child: Image.asset(Images.trophy.toPath)),
                              const SizedBox(height: 10),
                              Text(
                                record,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 36),
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
            PlayAgainButton(controller: controller, userWon: win),
          ],
        ),
      ),
    );
  }

  static void exitGame(BuildContext context, GameController gameController) {
    const String title = "Exit game?";
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
              gameController.createNewGame();
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeView()),
                  (route) => false);
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
}
