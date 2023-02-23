import 'package:flutter/material.dart';
import 'package:minesweeper/view/game_view/app_bar.dart';
import 'package:minesweeper/view/game_view/mine_field.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      appBar: GameAppBar(),
      body: MineField(),
    );
  }
}
