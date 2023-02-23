import 'dart:math';

import 'package:flutter/material.dart';

class GameController extends ChangeNotifier {
  final List<List<int>> _mineField = [];

  List<List<int>> get mineField => _mineField;

  GameController() {
    if (_mineField.isEmpty) {
      putMines();
    }
  }

  List<List<int>> putMines({int mines = 15}) {
    _mineField.clear();
    for (var i = 0; i < 10; i++) {
      _mineField.add([]);
      for (var j = 0; j < 10; j++) {
        _mineField[i].add(0);
      }
    }
    var rnd = Random();
    while (mines > 0) {
      var i = rnd.nextInt(10);
      var j = rnd.nextInt(10);
      if (_mineField[i][j] != 1) {
        _mineField[i][j] = 1;
        mines--;
      }
    }
    return _mineField;
  }
}
