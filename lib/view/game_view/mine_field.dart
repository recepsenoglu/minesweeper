import 'package:flutter/material.dart';
import 'package:minesweeper/constants/color_consts.dart';
import 'package:minesweeper/controller/game_controller.dart';
import 'package:minesweeper/model/tile_model.dart';
import 'package:provider/provider.dart';

class MineField extends StatefulWidget {
  const MineField({super.key});

  @override
  State<MineField> createState() => _MineFieldState();
}

class _MineFieldState extends State<MineField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<List<Tile>> mineField = Provider.of<GameController>(context).mineField;

    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
        itemCount: 100,
        itemBuilder: (BuildContext context, index) {
          Tile currentTile = mineField[index ~/ 10][index % 10];
          if (currentTile.visible == false) {
            return InkWell(
              onTap: () {},
              child: Grass(index: index),
            );
          } else {
            if (currentTile.hasMine) {
              return Mine(index: index);
            }
            return const SizedBox();
          }
        });
  }
}

class Grass extends StatelessWidget {
  final int index;
  const Grass({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: index % 2 == 0 && (index / 10).floor() % 2 == 0 ||
                index % 2 != 0 && (index / 10).floor() % 2 != 0
            ? GameColors.grassLight
            : GameColors.grassDark,
      ),
    );
  }
}

class Mine extends StatelessWidget {
  final int index;
  const Mine({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    Color mineColor = GameColors.mineColors[index % 7];
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: mineColor),
      child: CircleAvatar(
        backgroundColor: GameColors.darken(mineColor),
      ),
    );
  }
}
