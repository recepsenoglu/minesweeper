import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/game_colors.dart';
import '../../utils/game_images.dart';
import '../../utils/game_sizes.dart';
import '../../utils/game_strings.dart';
import '../../widgets/custom_button.dart';
import '../game_view/game_view.dart';
import '../statistics_view/statistics_view.dart';
import 'miniature_minefield.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColors.mainSkyBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: GameSizes.getHeight(0.05)),
          const GameTitle(),
          const MiniatureMinefield(),
          Column(
            children: [
              const NewGameButton(),
              SizedBox(height: GameSizes.getHeight(0.04)),
              const StatisticsButton(),
            ],
          ),
          Image.asset(Images.homeScreenBg.toPath),
        ],
      ),
    );
  }
}

class GameTitle extends StatelessWidget {
  const GameTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: GameSizes.getHorizontalPadding(0.1),
      child: FittedBox(
        child: Text(
          GameStrings.appName.toUpperCase(),
          style: TextStyle(
            letterSpacing: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: GameSizes.getWidth(0.09),
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      ),
    );
  }
}

class StatisticsButton extends StatelessWidget {
  const StatisticsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StatisticsView(),
            ));
      },
      color: Colors.white,
      elevation: 6,
      icon: Icons.bar_chart,
      text: GameStrings.statistics,
      textColor: GameColors.button,
      width: GameSizes.getWidth(0.35),
      textSize: GameSizes.getWidth(0.045),
      iconSize: GameSizes.getWidth(0.05),
    );
  }
}

class NewGameButton extends StatefulWidget {
  const NewGameButton({super.key});

  @override
  State<NewGameButton> createState() => _NewGameButtonState();
}

double _buttonWidth = GameSizes.getWidth(0.38);
double _top = 0;
double _left = 0;

class _NewGameButtonState extends State<NewGameButton> {
  @override
  void initState() {
    Timer.periodic(const Duration(milliseconds: 1300), (timer) {
      if (mounted) {
        setState(() {
          _buttonWidth = _buttonWidth >= GameSizes.getWidth(0.23)
              ? GameSizes.getWidth(0.23)
              : GameSizes.getWidth(0.3);
        });
      } else {
        timer.cancel();
      }
    });
    super.initState();
  }

  void _onTapDown() {
    setState(() {
      _top = GameSizes.getWidth(0.03);
      _left = GameSizes.getWidth(0.02);
    });
  }

  void _onTapUp() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _top = 0;
        _left = 0;
      });
    });
  }

  void _onTapDownWithDetails(TapDownDetails details) {
    _onTapDown();
  }

  void _onTapUpWithDetails(TapUpDetails details) {
    _onTapUp();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: GameSizes.getWidth(0.38),
          height: GameSizes.getWidth(0.32),
          margin: EdgeInsets.only(
            top: GameSizes.getWidth(0.03),
            left: GameSizes.getWidth(0.02),
          ),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: GameSizes.getRadius(22),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          top: _top,
          left: _left,
          curve: Curves.easeIn,
          child: GestureDetector(
            onTap: _onTapDown,
            onTapUp: _onTapUpWithDetails,
            onTapDown: _onTapDownWithDetails,
            onTapCancel: _onTapUp,
            child: CustomButton(
              text: '',
              onPressed: () {
                Future.delayed(const Duration(milliseconds: 200), () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameView(),
                      ));
                });
              },
              radius: 16,
              elevation: 20,
              width: GameSizes.getWidth(0.38),
              height: GameSizes.getWidth(0.32),
              padding: EdgeInsets.zero,
              color: Colors.grey.shade200,
              textColor: Colors.white,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  width: _buttonWidth,
                  height: _buttonWidth,
                  child: Image.asset(
                    Images.shovel.toPath,
                    width: _buttonWidth,
                    height: _buttonWidth,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
