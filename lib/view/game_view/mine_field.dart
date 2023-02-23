import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    GameController gameController =
        Provider.of<GameController>(context, listen: true);
    List<List<Tile>> mineField = gameController.mineField;

    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
        itemCount: 100,
        itemBuilder: (BuildContext context, index) {
          int row = index ~/ 10;
          int col = index % 10;
          Tile currentTile = mineField[row][col];

          if (currentTile.visible == false) {
            return InkWell(
              onTap: () {
                gameController.openTile(row, col);
              },
              child: Grass(index: index),
            );
          } else {
            if (currentTile.hasMine) {
              return Mine(index: index);
            }
            return OpenedTile(
              row: row,
              col: col,
              tile: currentTile,
            );
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
    Color mineColor =
        GameColors.mineColors[index % GameColors.mineColors.length];
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

class OpenedTile extends StatelessWidget {
  final int row;
  final int col;
  final Tile tile;

  const OpenedTile({
    super.key,
    required this.row,
    required this.col,
    required this.tile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: row % 2 == 0 && col % 2 == 0 || row % 2 != 0 && col % 2 != 0
            ? GameColors.tileLight
            : GameColors.tileDark,
      ),
      child: tile.value != 0
          ? Text(tile.toString(),
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: GameColors.valueTextColors[tile.value - 1]),
              ))
          : const SizedBox(),
    );
  }
}
