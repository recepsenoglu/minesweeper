import 'package:flutter/material.dart';
import 'package:minesweeper/utils/game_sizes.dart';
import 'package:provider/provider.dart';

import '../../controller/game_controller.dart';
import '../../utils/extensions.dart';
import '../../utils/game_colors.dart';
import '../../utils/game_consts.dart';
import '../../utils/game_images.dart';
import '../../widgets/game_popup_screen.dart';
import '../home_view/home_view.dart';

class GameTopBar extends StatelessWidget {
  const GameTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GameColors.appBar,
      padding: GameSizes.getSymmetricPadding(0.02, 0.01),
      child: Consumer<GameController>(
        builder: (context, GameController controller, child) => Row(
          children: [
            DifficultySettings(controller: controller),
            const Spacer(),
            Flags(flagCount: controller.flagCount),
            SizedBox(width: GameSizes.getWidth(0.04)),
            Stopwatch(timeElapsed: controller.timeElapsed),
            const Spacer(),
            IconButton(
              onPressed: () {
                controller.changeVolumeSetting = !controller.volumeOn;
              },
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              icon: Icon(
                controller.volumeOn ? Icons.volume_up : Icons.volume_off_sharp,
                color: controller.volumeOn ? Colors.white : Colors.white70,
              ),
              iconSize: GameSizes.getWidth(0.075),
            ),
            IconButton(
              onPressed: () => controller.gameHasStarted
                  ? GamePopupScreen.exitGame(context, controller)
                  : Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeView(),
                      ),
                      (route) => false),
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.close, color: Colors.white),
              iconSize: GameSizes.getWidth(0.07),
            ),
          ],
        ),
      ),
    );
  }
}

class Stopwatch extends StatelessWidget {
  final int timeElapsed;
  const Stopwatch({super.key, required this.timeElapsed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          Images.stopwatch.toPath,
          width: GameSizes.getWidth(0.07),
        ),
        SizedBox(width: GameSizes.getWidth(0.01)),
        Container(
          width: GameSizes.getWidth(0.09),
          alignment: Alignment.centerLeft,
          child: Text(
            "0" * (3 - timeElapsed.toString().length) + timeElapsed.toString(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: GameSizes.getWidth(0.045),
            ),
          ),
        ),
      ],
    );
  }
}

class Flags extends StatelessWidget {
  final int flagCount;
  const Flags({super.key, required this.flagCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          Images.flag.toPath,
          width: GameSizes.getWidth(0.08),
        ),
        SizedBox(width: GameSizes.getWidth(0.01)),
        Text(
          flagCount.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: GameSizes.getWidth(0.045),
          ),
        ),
      ],
    );
  }
}

class DifficultySettings extends StatelessWidget {
  final GameController controller;
  const DifficultySettings({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    GameMode gameMode = controller.gameMode;
    List<GameMode> allModes = [GameMode.easy, GameMode.medium, GameMode.hard];

    return Container(
      height: GameSizes.getWidth(0.08),
      margin: GameSizes.getSymmetricPadding(0.02, 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: GameSizes.getRadius(6),
      ),
      child: Center(
        child: DropdownButton<GameMode>(
          isDense: true,
          value: gameMode,
          alignment: Alignment.center,
          borderRadius: GameSizes.getRadius(10),
          underline: const SizedBox(),
          items: allModes.map<DropdownMenuItem<GameMode>>((GameMode value) {
            return DropdownMenuItem<GameMode>(
              value: value,
              child: Text(
                value.name.capitalizeFirst(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: GameSizes.getWidth(0.045),
                ),
              ),
            );
          }).toList(),
          style:  TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: GameSizes.getWidth(0.04),
          ),
          onChanged: (value) {
            if (value != null && value != controller.gameMode) {
              controller.gameMode = value;
            }
          },
        ),
      ),
    );
  }
}
