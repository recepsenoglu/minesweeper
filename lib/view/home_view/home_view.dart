import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/color_consts.dart';
import '../../constants/image_enums.dart';
import '../game_view/game_view.dart';
import '../statistics_view/statistics_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColors.homeScreenScaffold,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: GameColors.homeScreenScaffold,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Column(
        children: [
          const Spacer(),
          const GameTitle(),
          const Spacer(),
          const MiniatureMinefield(),
          const Spacer(),
          const NewGameButton(),
          const SizedBox(height: 22),
          const StatisticsButton(),
          const SizedBox(height: 22),
          const Spacer(),
          Image.asset(Images.homeScreenBg.toPath),
        ],
      ),
    );
  }
}

class StatisticsButton extends StatelessWidget {
  const StatisticsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StatisticsView(),
            ));
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      icon: const Icon(Icons.bar_chart),
      label: const Text(
        "Statistics",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}

class NewGameButton extends StatelessWidget {
  const NewGameButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const GameView(),
            ),
            (route) => false);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      child: const Text(
        "New game",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class GameTitle extends StatelessWidget {
  const GameTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String title = "MINESWEEPER";

    return Text(
      title,
      style: TextStyle(
        fontFamily: GoogleFonts.roboto().fontFamily,
        fontWeight: FontWeight.bold,
        letterSpacing: 4,
        fontSize: 42,
      ),
    );
  }
}

class MiniatureMinefield extends StatefulWidget {
  const MiniatureMinefield({
    super.key,
  });

  @override
  State<MiniatureMinefield> createState() => _MiniatureMinefieldState();
}

class _MiniatureMinefieldState extends State<MiniatureMinefield> {
  @override
  Widget build(BuildContext context) {
    var rnd = Random();
    List<int> minePlaces = [
      rnd.nextInt(20),
      rnd.nextInt(20),
      rnd.nextInt(20),
    ];
    return GestureDetector(
      onTap: () => setState(() {}),
      child: SizedBox(
        height: 172,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10),
          itemCount: 40,
          itemBuilder: (BuildContext context, index) {
            Color? mineColor;
            bool mineCell = minePlaces.contains(index - 19);
            if (mineCell) {
              var rnd = Random();

              mineColor = GameColors
                  .mineColors[rnd.nextInt(GameColors.mineColors.length)];
            }
            return Container(
              decoration: BoxDecoration(
                color: mineCell
                    ? mineColor
                    : (index / 10).floor() < 2
                        ? index % 2 == (index / 10).floor() % 2
                            ? GameColors.grassLight
                            : GameColors.grassDark
                        : index % 2 != (index / 10).floor() % 2
                            ? GameColors.tileDark
                            : GameColors.tileLight,
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              child: mineCell
                  ? CircleAvatar(
                      backgroundColor: GameColors.darken(mineColor!),
                    )
                  : const SizedBox(),
            );
          },
        ),
      ),
    );
  }
}
