import 'package:flutter/material.dart';

import '../../constants/game_consts.dart';
import 'app_bar.dart';
import 'stats_table.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: StatsAppBar(),
        body: TabBarView(children: [
          StatsTable(gameMode: GameMode.easy),
          StatsTable(gameMode: GameMode.medium),
          StatsTable(gameMode: GameMode.hard),
        ]),
      ),
    );
  }
}
