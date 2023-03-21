import 'package:flutter/material.dart';

import '../../constants/color_consts.dart';
import '../../constants/game_consts.dart';

class StatsTable extends StatelessWidget {
  final GameMode gameMode;
  const StatsTable({super.key, required this.gameMode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: const [
          StatWidget(
            iconData: Icons.grid_on_rounded,
            statName: "Games Started",
            statValue: "10",
          ),
          StatWidget(
            iconData: Icons.workspace_premium_outlined,
            statName: "Games Won",
            statValue: "7",
          ),
          StatWidget(
            iconData: Icons.flag_outlined,
            statName: "Win Rate",
            statValue: "100%",
          ),
          StatWidget(
            iconData: Icons.timer_outlined,
            statName: "Best Time",
            statValue: "03:19",
          ),
          StatWidget(
            iconData: Icons.access_time_sharp,
            statName: "Average Time",
            statValue: "03:40",
          ),
        ],
      ),
    );
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
  final String statValue;

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
            statValue,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
