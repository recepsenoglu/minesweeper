import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/game_controller.dart';
import 'view/home_view/home_view.dart';

void main() {
  runApp(ChangeNotifierProvider<GameController>(
    create: (context) => GameController(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minesweeper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
    );
  }
}
