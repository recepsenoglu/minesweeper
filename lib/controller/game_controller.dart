import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/game_consts.dart';
import '../model/tile_model.dart';

class GameController extends ChangeNotifier {
  /// The game board matrix / minefield
  final List<List<Tile>> _mineField = [];
  List<List<Tile>> get mineField => _mineField;

  /// Game difficulty setting.
  /// This setting determines the matrix size and number of mines
  GameMode _gameMode = GameMode.easy;

  GameMode get gameMode => _gameMode;

  set gameMode(GameMode mode) {
    _gameMode = mode;
    _boardLength = boardLength(_gameMode);
    _mineCount = mineCount(_gameMode);
    resetGame();
    createGameBoard();
  }

  /// Reset game variables
  void resetGame() {
    _mineField.clear();
    _flagCount = _mineCount;
    _gameHasStarted = false;
    _gameOver = false;
  }

  int _boardLength = 10;
  int _mineCount = 15;

  int _flagCount = 15;
  int get flagCount => _flagCount;

  bool _gameHasStarted = false;
  bool _gameOver = false;

  GameController() {
    createGameBoard();
  }

  /// Creates empty board
  void createGameBoard() {
    for (var i = 0; i < _boardLength; i++) {
      _mineField.add([]);
      for (var j = 0; j < 10; j++) {
        _mineField[i].add(Tile());
      }
    }
  }

  /// Places mines to empty game board. The number of mines depends on the game difficulty.
  void placeMines(int row, int col) {
    var rnd = Random();
    int mines = _mineCount;
    while (mines > 0) {
      var i = rnd.nextInt(_boardLength);
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

  /// Remove/Add flag from/to specified tile
  void placeFlag(int row, int col, bool value) {
    _mineField[row][col].setFlag = value;
    _flagCount += value ? 1 : -1;
    notifyListeners();
  }

  /// Opens the clicked tile. Calls the [checkMinesAround] function and updates
  /// the tile value as mine count.
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
        openTile(row - 1, col - 1);
        openTile(row - 1, col + 1);
        openTile(row + 1, col - 1);
        openTile(row + 1, col + 1);
      }
    }
  }

  /// Checks for surrounding mines and returns number of mines
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
