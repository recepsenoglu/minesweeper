import 'package:flutter/material.dart';

import '../../../utils/game_sizes.dart';
import '../../../widgets/custom_button.dart';
import '../../settings_view/settings_view.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SettingsView(),
            ));
      },
      color: const Color(0xFFE0E0E0),
      elevation: 6,
      icon: Icons.settings,
      text: "Settings",
      textColor: Colors.black,
      width: GameSizes.getWidth(0.35),
      textSize: GameSizes.getWidth(0.045),
      iconSize: GameSizes.getWidth(0.05),
    );
  }
}
