import 'package:flutter/material.dart';
import 'package:minesweeper/view/game_view/app_bar.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const GameAppBar(),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10,
            childAspectRatio: 1,
          ),
          itemCount: 100,
          itemBuilder: (BuildContext context, index) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: index % 2 == 0 && (index / 10).floor() % 2 == 0 ||
                        index % 2 != 0 && (index / 10).floor() % 2 != 0
                    ? const Color(0xFFB3D665)
                    : const Color(0xFFACD05E),
              ),
              child: Text(index.toString()),
            );
          }),
    );
  }
}
