import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/color_consts.dart';

class StatsAppBar extends StatelessWidget with PreferredSizeWidget {
  const StatsAppBar({
    super.key,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    const String appBarTitle = "Game stats";

    return AppBar(
      elevation: 0,
      backgroundColor: GameColors.homeScreenScaffold,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      title: const Text(appBarTitle),
      titleTextStyle: const TextStyle(fontSize: 24),
    );
  }
}
