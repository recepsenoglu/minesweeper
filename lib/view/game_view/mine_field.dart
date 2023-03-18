import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minesweeper/constants/color_consts.dart';
import 'package:minesweeper/constants/image_enums.dart';
import 'package:minesweeper/controller/game_controller.dart';
import 'package:minesweeper/model/tile_model.dart';
import 'package:minesweeper/widgets/lose_popup.dart';
import 'package:minesweeper/widgets/win_popup.dart';
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
        itemCount: gameController.boardLength * 10,
        itemBuilder: (BuildContext context, index) {
          Tile tile = mineField[index ~/ 10][index % 10];

          if (tile.visible == false) {
            return Grass(tile: tile, gameController: gameController);
          } else {
            if (tile.hasMine) {
              return Mine(index: index);
            }
            return OpenedTile(tile: tile);
          }
        });
  }
}

class Grass extends StatelessWidget {
  final Tile tile;
  final GameController gameController;

  const Grass({super.key, required this.tile, required this.gameController});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (!tile.hasFlag) {
            bool? userWon = gameController.clickTile(tile);
            if (userWon == true) {
              showWinScreen(context, controller: gameController);
            } else if (userWon == false) {
              showLoseScreen(context, controller: gameController);
            }
          }
        },
        onLongPress: () => gameController.placeFlag(tile),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: tile.row % 2 == 0 && tile.col % 2 == 0 ||
                      tile.row % 2 != 0 && tile.col % 2 != 0
                  ? GameColors.grassLight
                  : GameColors.grassDark,
              border: Border(
                left: BorderSide(
                  width: 3,
                  color: GameColors.tileBorder,
                  style: tile.ltrb[0] ? BorderStyle.solid : BorderStyle.none,
                ),
                top: BorderSide(
                  width: 3,
                  color: GameColors.tileBorder,
                  style: tile.ltrb[1] ? BorderStyle.solid : BorderStyle.none,
                ),
                right: BorderSide(
                  width: 3,
                  color: GameColors.tileBorder,
                  style: tile.ltrb[2] ? BorderStyle.solid : BorderStyle.none,
                ),
                bottom: BorderSide(
                  width: 3,
                  color: GameColors.tileBorder,
                  style: tile.ltrb[3] ? BorderStyle.solid : BorderStyle.none,
                ),
              )),
          child: tile.hasFlag
              ? Image.asset(Images.bookmark.toPath)
              : const SizedBox(),
        ));
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
  final Tile tile;

  const OpenedTile({super.key, required this.tile});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: tile.row % 2 == 0 && tile.col % 2 == 0 ||
                tile.row % 2 != 0 && tile.col % 2 != 0
            ? GameColors.tileLight
            : GameColors.tileDark,
      ),
      child: tile.value > 0
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
