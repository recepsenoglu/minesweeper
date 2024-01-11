import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper/utils/exports.dart';

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
        padding: GameSizes.getHorizontalPadding(0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: GameSizes.getWidth(0.8),
              decoration: BoxDecoration(
                color: GameColors.popupBackground,
                borderRadius: GameSizes.getRadius(16),
              ),
              child: Stack(
                children: [
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(win
                              ? Images.winScreen.toPath
                              : Images.loseScreen.toPath))),
                  Padding(
                    padding: GameSizes.getSymmetricPadding(0.03, 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: GameSizes.getWidth(0.18),
                              child: Image.asset(Images.stopwatch.toPath),
                            ),
                            SizedBox(height: GameSizes.getWidth(0.01)),
                            Text(
                              time,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: GameSizes.getWidth(0.09),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: GameSizes.getWidth(0.18),
                              child: Image.asset(Images.trophy.toPath),
                            ),
                            SizedBox(height: GameSizes.getWidth(0.01)),
                            Text(
                              record,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: GameSizes.getWidth(0.09),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: GameSizes.getHeight(0.02)),
            PlayAgainButton(controller: controller, win: win),
          ],
        ),
      ),
    );
  }

  static void exitGame(BuildContext context, GameController gameController) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "exitGame".tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: GameSizes.getWidth(0.05),
          ),
        ),
        content: Text(
          "exitGameMessage".tr(),
          style: TextStyle(
            fontSize: GameSizes.getWidth(0.04),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "no".tr(),
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: GameSizes.getWidth(0.04),
              ),
            ),
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
            child: Text(
              "yes".tr(),
              style: TextStyle(
                color: Colors.red.shade700,
                fontWeight: FontWeight.bold,
                fontSize: GameSizes.getWidth(0.04),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
