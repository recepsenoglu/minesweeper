import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minesweeper/model/tile_model.dart';

class GameController extends ChangeNotifier {
  final List<List<Tile>> _mineField = [];

  List<List<Tile>> get mineField => _mineField;

  GameController() {
    if (_mineField.isEmpty) {
      placeMines();
    }
  }

  void placeMines({int mines = 15}) {
    _mineField.clear();
    for (var i = 0; i < 10; i++) {
      _mineField.add([]);
      for (var j = 0; j < 10; j++) {
        _mineField[i].add(Tile());
      }
    }
    var rnd = Random();
    while (mines > 0) {
      var i = rnd.nextInt(10);
      var j = rnd.nextInt(10);
      if (!_mineField[i][j].hasMine) {
        _mineField[i][j].setMine = true;
        _mineField[i][j].changeVisibility = true;
        mines--;
      }
    }
  }
}
