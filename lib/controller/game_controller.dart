import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/game_consts.dart';
import '../model/tile_model.dart';

class GameController extends ChangeNotifier {
  /// The game board matrix / minefield
  final List<List<Tile>> _mineField = [];
  List<List<Tile>> get mineField => _mineField;

  int _boardLength = 10;
  int get boardLength => _boardLength;

  int _flagCount = 15;
  int get flagCount => _flagCount;

  int _mineCount = 15;
  int _openedTileCount = 0;

  bool _gameHasStarted = false;
  bool _gameOver = false;

  /// Game difficulty setting.
  /// This setting determines the matrix size and number of mines
  GameMode _gameMode = GameMode.easy;

  GameMode get gameMode => _gameMode;

  set gameMode(GameMode mode) {
    _gameMode = mode;
    _boardLength = getBoardLength(_gameMode);
    _mineCount = mineCount(_gameMode);
    createNewGame();
  }

  void createNewGame() {
    resetGame();
    _createGameBoard();
    notifyListeners();
  }

  void startGame(int row, int col) {
    _gameHasStarted = true;
    _placeMines(row, col);
    _openTile(row, col);
  }

  /// Reset game variables
  void resetGame() {
    _mineField.clear();
    _flagCount = _mineCount;
    _openedTileCount = 0;
    _gameHasStarted = false;
    _gameOver = false;
  }

  GameController() {
    _createGameBoard();
  }

  void winTheGame() {
    _gameOver = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 2), () {
      debugPrint("Game Over!!!");
    });
  }

  void loseTheGame() {
    _gameOver = true;
    showAllMines();
    notifyListeners();
    Future.delayed(const Duration(seconds: 2), () {
      debugPrint("Game Over!!!");
    });
  }

  void showAllMines() {
    for (var r = 0; r < _boardLength; r++) {
      for (var c = 0; c < 10; c++) {
        if (mineField[r][c].hasMine && !mineField[r][c].hasFlag) {
          mineField[r][c].setVisible = true;
        }
      }
    }
  }

  /// Creates empty board
  void _createGameBoard() {
    for (var i = 0; i < _boardLength; i++) {
      _mineField.add([]);
      for (var j = 0; j < 10; j++) {
        _mineField[i].add(Tile());
      }
    }
  }

  /// Places mines to empty game board. The number of mines depends on the game difficulty.
  void _placeMines(int row, int col) {
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
        mines--;
      }
    }
  }

  /// Remove/Add flag from/to specified tile
  void placeFlag(int row, int col, bool value) {
    if (!_gameOver) {
      _mineField[row][col].setFlag = value;
      _flagCount += value ? -1 : 1;
      notifyListeners();
    }
  }

  bool? clickTile(int row, int col) {
    if (!_gameHasStarted) {
      startGame(row, col);
    } else if (!_gameOver) {
      return _openTile(row, col);
    }
    return null;
  }

  /// Opens the clicked tile. Calls the [checkMinesAround] function and updates
  /// the tile value as mine count.
  bool? _openTile(int row, int col) {
    if (row < 0 ||
        col < 0 ||
        row >= mineField.length ||
        col >= mineField[0].length) return null;
    if (mineField[row][col].visible) return null;

    if (mineField[row][col].hasMine) {
      loseTheGame();
      return false;
    } else {
      _openedTileCount++;
      int minesAround = checkMinesAround(row, col);
      mineField[row][col].setValue = minesAround;
      if (mineField[row][col].hasFlag) {
        _flagCount += 1;
      }

      notifyListeners();

      if (_openedTileCount + _mineCount == _boardLength * 10) {
        winTheGame();
        return true;
      } else if (minesAround == 0) {
        _openTile(row + 1, col - 1);
        _openTile(row + 1, col);
        _openTile(row + 1, col + 1);
        _openTile(row, col - 1);
        _openTile(row, col + 1);
        _openTile(row - 1, col - 1);
        _openTile(row - 1, col);
        _openTile(row - 1, col + 1);
      }
      return null;
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
