import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/color_consts.dart';

class MiniatureMinefield extends StatefulWidget {
  const MiniatureMinefield({
    super.key,
  });

  @override
  State<MiniatureMinefield> createState() => _MiniatureMinefieldState();
}

class _MiniatureMinefieldState extends State<MiniatureMinefield> {
  void startTimer() {
    Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      if (mounted) {
        setState(() {});
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var rnd = Random();
    List<int> minePlaces = [
      rnd.nextInt(20),
      rnd.nextInt(20),
      rnd.nextInt(20),
    ];

    return SizedBox(
      height: 172,
      child: Center(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10),
          itemCount: 40,
          itemBuilder: (BuildContext context, index) {
            Color? mineColor;
            bool mineCell = minePlaces.contains(index - 19);
            if (mineCell) {
              var rnd = Random();

              mineColor = GameColors
                  .mineColors[rnd.nextInt(GameColors.mineColors.length)];
            }
            return Container(
              decoration: BoxDecoration(
                color: mineCell
                    ? mineColor
                    : (index / 10).floor() < 2
                        ? index % 2 == (index / 10).floor() % 2
                            ? GameColors.grassLight
                            : GameColors.grassDark
                        : index % 2 != (index / 10).floor() % 2
                            ? GameColors.tileDark
                            : GameColors.tileLight,
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              child: mineCell
                  ? CircleAvatar(
                      backgroundColor: GameColors.darken(mineColor!),
                    )
                  : const SizedBox(),
            );
          },
        ),
      ),
    );
  }
}
