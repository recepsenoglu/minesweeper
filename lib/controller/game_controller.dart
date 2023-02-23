import 'dart:developer' as dev;
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
        _mineField[i][j].setVisible = true;
        mines--;
      }
    }
  }

  void placeFlag(int row, int col, bool value) {
    _mineField[row][col].setFlag = value;
    notifyListeners();
  }

  void openTile(int row, int col) {
    if (row >= 0 &&
        col >= 0 &&
        row < mineField.length &&
        col < mineField[0].length) {
      int minesAround = checkMinesAround(row, col);
      mineField[row][col].setValue = minesAround;

      notifyListeners();
    }
  }

  int checkMinesAround(int row, int col) {
    int rowLength = mineField.length;
    int colLength = mineField[0].length;

    dev.log("[$row,$col]");

    int minesAround = 0;

    if (row - 1 >= 0 && col - 1 >= 0 && mineField[row - 1][col - 1].hasMine) {
      minesAround++;
    }
    if (row - 1 >= 0 && mineField[row - 1][col].hasMine) {
      minesAround++;
    }
    if (row - 1 >= 0 &&
        col + 1 < colLength &&
        mineField[row - 1][col + 1].hasMine) {
      minesAround++;
    }
    if (col - 1 >= 0 && mineField[row][col - 1].hasMine) {
      minesAround++;
    }
    if (col + 1 < colLength && mineField[row][col + 1].hasMine) {
      minesAround++;
    }
    if (row + 1 < rowLength &&
        col - 1 >= 0 &&
        mineField[row + 1][col - 1].hasMine) {
      minesAround++;
    }
    if (row + 1 < rowLength && mineField[row + 1][col].hasMine) {
      minesAround++;
    }
    if (row + 1 < rowLength &&
        col + 1 < colLength &&
        mineField[row + 1][col + 1].hasMine) {
      minesAround++;
    }

    return minesAround;
  }
}
