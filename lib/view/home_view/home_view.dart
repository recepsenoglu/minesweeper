import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/color_consts.dart';
import '../../constants/image_enums.dart';
import '../game_view/game_view.dart';
import '../statistics_view/statistics_view.dart';
import 'miniature_minefield.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColors.mainSkyBlue,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: GameColors.mainSkyBlue,
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: FittedBox(
        child: Text(
          title,
          style: TextStyle(
            fontFamily: GoogleFonts.roboto().fontFamily,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
            fontSize: 42,
          ),
        ),
      ),
    );
  }
}
