import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minesweeper/constants/color_consts.dart';
import 'package:minesweeper/view/home_view/home_view.dart';
import 'package:provider/provider.dart';

import '../../constants/game_consts.dart';
import '../../constants/image_enums.dart';
import '../../controller/game_controller.dart';
import '../../helper/functions.dart';
import '../../widgets/game_popup_screen.dart';

class GameAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GameAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: GameColors.appBar,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      centerTitle: true,
      title: Consumer<GameController>(
        builder: (context, GameController controller, child) => Row(
          children: [
            DifficultySettings(controller: controller),
            const Spacer(),
            Flags(flagCount: controller.flagCount),
            const SizedBox(width: 15),
            Stopwatch(timeElapsed: controller.timeElapsed),
            const Spacer(),
            SizedBox(
              width: 25,
              child: IconButton(
                visualDensity: VisualDensity.compact,
                icon: Icon(controller.volumeOn
                    ? Icons.volume_up
                    : Icons.volume_off_sharp),
                padding: EdgeInsets.zero,
                splashRadius: 20,
                iconSize: 30,
                onPressed: () {
                  controller.changeVolumeSetting = !controller.volumeOn;
                },
              ),
            ),
            const SizedBox(width: 5),
            SizedBox(
              width: 25,
              child: IconButton(
                visualDensity: VisualDensity.compact,
                icon: const Icon(Icons.close),
                padding: EdgeInsets.zero,
                splashRadius: 20,
                iconSize: 30,
                onPressed: () => controller.gameHasStarted
                    ? GamePopupScreen.exitGame(context, controller)
                    : Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeView(),
                        ),
                        (route) => false),
              ),
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
        Image.asset(Images.stopwatch.toPath, scale: 1.8),
        const SizedBox(width: 5),
        Container(
          alignment: Alignment.centerLeft,
          width: 42,
          child: Text("0" * (3 - timeElapsed.toString().length) +
              timeElapsed.toString()),
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
        Image.asset(Images.bookmark.toPath, scale: 1.1),
        const SizedBox(width: 6),
        Text(flagCount.toString()),
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
      height: 36,
      margin: const EdgeInsets.symmetric(vertical: 10).copyWith(right: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: DropdownButton<GameMode>(
          value: gameMode,
          isDense: true,
          alignment: Alignment.center,
          borderRadius: BorderRadius.circular(10),
          underline: const SizedBox(),
          items: allModes.map<DropdownMenuItem<GameMode>>((GameMode value) {
            return DropdownMenuItem<GameMode>(
              value: value,
              child: Text(value.name.capitalizeFirst()),
            );
          }).toList(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16,
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
