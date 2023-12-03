import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/exports.dart';
import 'components/animated_play_button.dart';
import 'components/miniature_minefield.dart';
import 'components/statistics_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColors.mainSkyBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: GameSizes.getHeight(0.05)),
          const GameTitle(),
          const MiniatureMinefield(),
          Column(
            children: [
              const AnimatedPlayButton(),
              SizedBox(height: GameSizes.getHeight(0.04)),
              const StatisticsButton(),
            ],
          ),
          Image.asset(Images.homeScreenBg.toPath),
        ],
      ),
    );
  }
}

class GameTitle extends StatelessWidget {
  const GameTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: GameSizes.getHorizontalPadding(0.1),
      child: FittedBox(
        child: Text(
          GameStrings.appName.toUpperCase(),
          style: TextStyle(
            letterSpacing: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: GameSizes.getWidth(0.09),
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      ),
    );
  }
}
