import 'package:flutter/material.dart';
import 'package:minesweeper/utils/game_colors.dart';
import 'package:minesweeper/utils/game_sizes.dart';
import 'package:minesweeper/utils/game_strings.dart';

import '../../utils/game_consts.dart';
import 'stats_table.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          toolbarHeight: GameSizes.getHeight(0.08),
          backgroundColor: GameColors.mainSkyBlue,
          title: const Text(GameStrings.gameStats),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: GameSizes.getWidth(0.055),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: GameSizes.getWidth(0.06),
            splashRadius: GameSizes.getWidth(0.06),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
            tabs: const [
              Tab(text: GameStrings.easy),
              Tab(text: GameStrings.medium),
              Tab(text: GameStrings.hard),
            ],
            indicator: const BoxDecoration(),
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: GameSizes.getWidth(0.042),
              letterSpacing: 2,
            ),
            unselectedLabelStyle: const TextStyle(color: Colors.white60),
          ),
        ),
        body: const TabBarView(children: [
          StatsTable(gameMode: GameMode.easy),
          StatsTable(gameMode: GameMode.medium),
          StatsTable(gameMode: GameMode.hard),
        ]),
      ),
    );
  }
}
