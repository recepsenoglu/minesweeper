import 'package:flutter/material.dart';
import 'package:minesweeper/controller/game_controller.dart';
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
    List<List<int>> mineField = Provider.of<GameController>(context).mineField;

    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
        itemCount: 100,
        itemBuilder: (BuildContext context, index) {
          if (mineField[index ~/ 10][index % 10] == 1) {
            return const SizedBox();
          }
          return Grass(index: index);
        });
  }
}

class Grass extends StatelessWidget {
  final int index;
  const Grass({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: index % 2 == 0 && (index / 10).floor() % 2 == 0 ||
                index % 2 != 0 && (index / 10).floor() % 2 != 0
            ? const Color(0xFFB3D665)
            : const Color(0xFFACD05E),
      ),
      child: const Text(""),
    );
  }
}
