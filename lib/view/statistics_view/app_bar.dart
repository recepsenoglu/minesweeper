import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/color_consts.dart';

class StatsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StatsAppBar({
    super.key,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.7);

  @override
  Widget build(BuildContext context) {
    const String appBarTitle = "Game stats";
    const String easyStr = "Easy";
    const String mediumStr = "Medium";
    const String hardStr = "Hard";

    return AppBar(
      elevation: 0,
      backgroundColor: GameColors.mainSkyBlue,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      title: const Text(appBarTitle),
      titleTextStyle: const TextStyle(fontSize: 24),
      bottom: const TabBar(
        tabs: [
          Tab(text: easyStr),
          Tab(text: mediumStr),
          Tab(text: hardStr),
        ],
        indicator: BoxDecoration(),
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(color: Colors.white10),
      ),
    );
  }
}
