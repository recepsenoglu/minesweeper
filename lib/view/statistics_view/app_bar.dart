import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/color_consts.dart';

class StatsAppBar extends StatelessWidget with PreferredSizeWidget {
  const StatsAppBar({
    super.key,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.7);

  @override
  Widget build(BuildContext context) {
    const String appBarTitle = "Game stats";

    return AppBar(
      elevation: 0,
      backgroundColor: GameColors.homeScreenScaffold,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      title: const Text(appBarTitle),
      titleTextStyle: const TextStyle(fontSize: 24),
      bottom: const TabBar(
        tabs: [
          Tab(text: "Easy"),
          Tab(text: "Medium"),
          Tab(text: "Hard"),
        ],
        indicator: BoxDecoration(),
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(color: Colors.white10),
      ),
    );
  }
}
