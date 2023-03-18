import 'dart:io';
import 'package:flutter/material.dart';
import '../controller/game_controller.dart';
import '../constants/color_consts.dart';
import '../constants/image_enums.dart';
import 'play_again_button.dart';

class GamePopupScreen {
  GamePopupScreen(_);

  static void gameOver(BuildContext context,
      {required GameController controller, required bool win}) {
    String time = win
        ? "0" * (3 - controller.timeElapsed.toString().length) +
            controller.timeElapsed.toString()
        : "---";
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
                                time,
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

  static void exitGame(BuildContext context) {
    const String title = "Do you want to exit?";
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
}