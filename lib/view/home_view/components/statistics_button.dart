import 'package:flutter/material.dart';

import '../../../utils/game_colors.dart';
import '../../../utils/game_sizes.dart';
import '../../../utils/game_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../statistics_view/statistics_view.dart';


class StatisticsButton extends StatelessWidget {
  const StatisticsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StatisticsView(),
            ));
      },
      color: Colors.white,
      elevation: 6,
      icon: Icons.bar_chart,
      text: GameStrings.statistics,
      textColor: GameColors.darkBlue,
      width: GameSizes.getWidth(0.35),
      textSize: GameSizes.getWidth(0.045),
      iconSize: GameSizes.getWidth(0.05),
    );
  }
}

