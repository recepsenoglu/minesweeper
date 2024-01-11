import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/exports.dart';
import '../../widgets/custom_button.dart';
import '../settings_view/settings_view.dart';
import '../statistics_view/statistics_view.dart';
import 'components/animated_play_button.dart';
import 'components/miniature_minefield.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColors.mainSkyBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: GameSizes.getHeight(0.05)),
          GameTitle(title: 'minesweeper'.tr()),
          const MiniatureMinefield(),
          Column(
            children: [
              const AnimatedPlayButton(),
              SizedBox(height: GameSizes.getHeight(0.04)),
              Padding(
                padding: GameSizes.getHorizontalPadding(0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const StatisticsView(),
                              ));
                        },
                        elevation: 6,
                        icon: Icons.bar_chart,
                        text: 'statistics'.tr(),
                        iconSize: GameSizes.getWidth(0.06),
                        height: GameSizes.getHeight(0.06),
                      ),
                    ),
                    SizedBox(width: GameSizes.getWidth(0.05)),
                    Expanded(
                      child: CustomButton(
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsView(),
                              ));
                          setState(() {});
                        },
                        elevation: 6,
                        icon: Icons.settings,
                        text: "settings".tr(),
                        iconSize: GameSizes.getWidth(0.06),
                        height: GameSizes.getHeight(0.06),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Image.asset(Images.homeScreenBg.toPath),
        ],
      ),
    );
  }
}

class GameTitle extends StatelessWidget {
  const GameTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: GameSizes.getHorizontalPadding(0.1),
      child: FittedBox(
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            letterSpacing: 4,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            backgroundColor: Colors.black,
            fontSize: GameSizes.getWidth(0.1),
            fontFamily: GoogleFonts.pressStart2p().fontFamily,
          ),
        ),
      ),
    );
  }
}
