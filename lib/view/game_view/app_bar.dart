import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minesweeper/constants/game_consts.dart';
import 'package:minesweeper/controller/game_controller.dart';
import 'package:minesweeper/helper/functions.dart';
import 'package:provider/provider.dart';

import '../../constants/image_enums.dart';

class GameAppBar extends StatelessWidget with PreferredSizeWidget {
  const GameAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF547436),
      systemOverlayStyle: SystemUiOverlayStyle.light,
      centerTitle: true,
      title: Consumer<GameController>(
        builder: (context, GameController controller, child) => Row(
          children: [
            DifficultySettings(controller: controller),
            const Spacer(),
            Flags(flagCount: controller.flagCount),
            const SizedBox(width: 15),
            const Stopwatch(timeElapsed: 24),
            const Spacer(),
          ],
        ),
      ),
      actions: [
        SizedBox(
          width: 40,
          child: IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.volume_up),
            padding: EdgeInsets.zero,
            splashRadius: 25,
            iconSize: 35,
            onPressed: () {},
          ),
        ),
        SizedBox(
          width: 50,
          child: IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.close),
            padding: EdgeInsets.zero,
            splashRadius: 25,
            iconSize: 35,
            onPressed: () {},
          ),
        ),
      ],
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
        Text(timeElapsed.toString()),
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
