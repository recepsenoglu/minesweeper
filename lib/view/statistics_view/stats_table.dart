import 'package:flutter/material.dart';
import 'package:minesweeper/helper/shared_helper.dart';

import '../../constants/color_consts.dart';
import '../../constants/game_consts.dart';

class StatsTable extends StatelessWidget {
  final GameMode gameMode;
  const StatsTable({super.key, required this.gameMode});

  String timeFormatter(int? time) {
    if (time == null) {
      return "--:--";
    }
    Duration duration = Duration(seconds: time);
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds - minutes * 60;
    return "${(minutes > 9 ? "" : "0")}$minutes:${(seconds > 9 ? "" : "0")}$seconds";
  }

  Future<Map<String, dynamic>> getStatistic(GameMode gameMode) async {
    final SharedHelper sharedHelper = await SharedHelper.init();

    int? gamesStarted = await sharedHelper.getGamesStarted(gameMode);
    int? gamesWon = await sharedHelper.getGamesWon(gameMode);
    int? bestTime = await sharedHelper.getBestTime(gameMode);
    int? averageTime = await sharedHelper.getAverageTime(gameMode);

    String? winRate;

    if (gamesStarted != null) {
      if (gamesWon != null) {
        winRate = "${(gamesWon * 100 / gamesStarted).round()}%";
      } else {
        winRate = "0%";
      }
    }

    return {
      "gamesStarted": gamesStarted,
      "gamesWon": gamesWon,
      "winRate": winRate,
      "bestTime": timeFormatter(bestTime),
      "averageTime": timeFormatter(averageTime),
    };
  }

  @override
  Widget build(BuildContext context) {
    const String errorStr =
        "There has been an error getting statistics. Please try again later.";
    return FutureBuilder(
        future: getStatistic(gameMode),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text(errorStr));
          }

          Map<String, dynamic> stats = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                StatWidget(
                  iconData: Icons.grid_on_rounded,
                  statName: "Games Started",
                  statValue: stats['gamesStarted'],
                ),
                StatWidget(
                  iconData: Icons.workspace_premium_outlined,
                  statName: "Games Won",
                  statValue: stats['gamesWon'],
                ),
                StatWidget(
                  iconData: Icons.flag_outlined,
                  statName: "Win Rate",
                  statValue: stats['winRate'],
                ),
                StatWidget(
                  iconData: Icons.timer_outlined,
                  statName: "Best Time",
                  statValue: stats['bestTime'],
                ),
                StatWidget(
                  iconData: Icons.access_time_sharp,
                  statName: "Average Time",
                  statValue: stats['averageTime'],
                ),
              ],
            ),
          );
        });
  }
}

class StatWidget extends StatelessWidget {
  const StatWidget({
    super.key,
    required this.iconData,
    required this.statName,
    required this.statValue,
  });

  final IconData iconData;
  final String statName;
  final dynamic statValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: GameColors.mainSkyBlue.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                iconData,
                size: 42,
                color: GameColors.darken(GameColors.mainSkyBlue),
              ),
              const SizedBox(height: 12),
              Text(
                statName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Text(
            statValue == null ? "-" : statValue.toString(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
