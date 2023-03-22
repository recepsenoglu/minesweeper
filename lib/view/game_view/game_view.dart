import 'package:flutter/material.dart';
import 'package:minesweeper/constants/color_consts.dart';

import '../../utils/audio_player.dart';
import 'app_bar.dart';
import 'mine_field.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      GameAudioPlayer.resume();
    } else {
      GameAudioPlayer.pause();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: GameColors.mainSkyBlue,
      appBar:const GameAppBar(),
      body:const MineField(),
    );
  }
}
