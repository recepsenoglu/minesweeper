import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minesweeper/model/tile_model.dart';

class GameController extends ChangeNotifier {
  /// The game board matrix / minefield
  final List<List<Tile>> _mineField = [];
  List<List<Tile>> get mineField => _mineField;

  bool _gameHasStarted = false;

  GameController() {
    createGameBoard();
  }

  void createGameBoard() {
    _mineField.clear();
    for (var i = 0; i < 10; i++) {
      _mineField.add([]);
      for (var j = 0; j < 10; j++) {
        _mineField[i].add(Tile());
      }
    }
  }

  void placeMines(int row, int col, {int mines = 15}) {
    var rnd = Random();
    while (mines > 0) {
      var i = rnd.nextInt(10);
      var j = rnd.nextInt(10);

      List<List<int>> restricted = [
        [row - 1, col - 1],
        [row - 1, col],
        [row - 1, col + 1],
        [row, col - 1],
        [row, col],
        [row, col + 1],
        [row + 1, col - 1],
        [row + 1, col],
        [row + 1, col + 1],
      ];

      if (restricted.any((element) => element[0] == i && element[1] == j)) {
        continue;
      }

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
    if (!_gameHasStarted) {
      _gameHasStarted = true;
      placeMines(row, col);
    }
    if (row >= 0 &&
        col >= 0 &&
        row < mineField.length &&
        col < mineField[0].length) {
      if (mineField[row][col].visible) return;

      int minesAround = checkMinesAround(row, col);
      mineField[row][col].setValue = minesAround;
      notifyListeners();

      if (minesAround == 0) {
        openTile(row + 1, col);
        openTile(row, col + 1);
        openTile(row, col - 1);
        openTile(row - 1, col);
      }
    }
  }

  int checkMinesAround(int row, int col) {
    int rowLength = mineField.length;
    int colLength = mineField[0].length;

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
