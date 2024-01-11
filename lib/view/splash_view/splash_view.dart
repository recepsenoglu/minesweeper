import 'package:flutter/material.dart';

import '../../helper/shared_helper.dart';
import '../../utils/game_sizes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Future<void> _init() async {
    await SharedHelper.init().then((sharedHelper) async {
      await sharedHelper.getHowToPlayShown().then((hasShown) {
        if (hasShown) {
          Navigator.of(context).pushReplacementNamed('/home_view');
        } else {
          Navigator.of(context)
              .pushReplacementNamed('/how_to_play_view', arguments: true);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: GameSizes.getWidth(0.5),
        ),
      ),
    );
  }
}
