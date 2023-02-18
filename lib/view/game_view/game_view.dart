import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF547436),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Container(),
    );
  }
}
