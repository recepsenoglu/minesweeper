import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:minesweeper/constants/audio_enums.dart';
import 'package:minesweeper/utils/audio_player.dart';
import '../constants/game_consts.dart';
import '../model/tile_model.dart';

class GameController extends ChangeNotifier {
  late GameAudioPlayer _audioPlayer;

  GameController() {
    _createGameBoard();
    _audioPlayer = GameAudioPlayer();
  }

  /// The game board matrix / minefield
  final List<List<Tile>> _mineField = [];
  List<List<Tile>> get mineField => _mineField;

  int _boardLength = 10;
  int get boardLength => _boardLength;

  int _flagCount = 15;
  int get flagCount => _flagCount;

  int _mineCount = 15;
  int _openedTileCount = 0;

  int _timeElapsed = 0;
  int get timeElapsed => _timeElapsed;

  bool _gameHasStarted = false;
  bool _gameOver = false;

  /// Game difficulty setting.
  /// This setting determines the matrix size and number of mines
  GameMode _gameMode = GameMode.easy;
  GameMode get gameMode => _gameMode;

  /// Game mode setter
  set gameMode(GameMode mode) {
    _gameMode = mode;
    _boardLength = getBoardLength(_gameMode);
    _mineCount = mineCount(_gameMode);
    resetGame();
    createNewGame();
  }

  /// Creates a new game
  void createNewGame() {
    resetGame();
    _createGameBoard();
    notifyListeners();
  }

  /// Game start function
  void startGame(Tile tile) {
    _gameHasStarted = true;
    startTimer();
    _placeMines(tile);
    _openTile(tile.row, tile.col);
  }

  /// Reset game variables
  void resetGame() {
    _gameOver = true;
    _mineField.clear();
    _flagCount = _mineCount;
    _openedTileCount = 0;
    _gameHasStarted = false;
    _gameOver = false;
    _timeElapsed = 0;
    notifyListeners();
  }

  /// Starts the timer
  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_gameHasStarted || _gameOver || _timeElapsed >= 999) {
        timer.cancel();
        return;
      }
      _timeElapsed++;
      notifyListeners();
    });
  }

  /// Win game function
  void winTheGame() {
    _gameOver = true;
    notifyListeners();
  }

  /// Lose game function
  void loseTheGame() {
    _gameOver = true;
    showAllMines();
    notifyListeners();
  }

  /// Makes all mines visible
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
        _mineField[i].add(Tile(i, j));
      }
    }
  }

  /// Places mines to empty game board. The number of mines depends on the game difficulty.
  void _placeMines(Tile tile) {
    var rnd = Random();
    int mines = _mineCount;
    int row = tile.row;
    int col = tile.col;

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
  void placeFlag(Tile tile) {
    if (!_gameOver) {
      bool flagValue = !tile.hasFlag;
      _mineField[tile.row][tile.col].setFlag = flagValue;
      _flagCount += flagValue ? -1 : 1;
      notifyListeners();
      _audioPlayer
          .playAudio(flagValue ? GameAudios.putFlag : GameAudios.removeFlag);
    }
  }

  /// When user clicks a tile, this function calls the [_openTile] function and starts the game if it is the first move of user's
  bool? clickTile(Tile tile) {
    if (!_gameHasStarted) {
      startGame(tile);
      _audioPlayer.playAudio(GameAudios.clickSounds[0]);
    } else if (!_gameOver) {
      return _openTile(tile.row, tile.col, playSound: true);
    }
    return null;
  }

  /// Opens the clicked tile. Calls the [checkMinesAround] function and updates
  /// the tile value as mine count.
  bool? _openTile(int row, int col, {bool playSound = false}) {
    if (row < 0 ||
        col < 0 ||
        row >= mineField.length ||
        col >= mineField[0].length) return null;
    if (mineField[row][col].visible) return null;
    if (mineField[row][col].hasMine) {
      loseTheGame();
      _audioPlayer.playAudio(GameAudios.lose);
      return false;
    }

    _openedTileCount++;
    int minesAround = checkMinesAround(row, col);
    mineField[row][col].setValue = minesAround;
    if (mineField[row][col].hasFlag) {
      _flagCount += 1;
    }
    notifyListeners();

    if (_openedTileCount + _mineCount == _boardLength * 10) {
      winTheGame();
      _audioPlayer.playAudio(GameAudios.lastHit).then((value) => Future.delayed(
          const Duration(milliseconds: 1500),
          () => _audioPlayer.playAudio(GameAudios.win)));
      return true;
    } else {
      if (playSound) {
        _audioPlayer.playAudio(GameAudios.clickSounds[
            minesAround > GameAudios.clickSounds.length
                ? GameAudios.clickSounds.last.index
                : minesAround]);
      }
      if (minesAround == 0) {
        _openTile(row + 1, col - 1);
        _openTile(row + 1, col);
        _openTile(row + 1, col + 1);
        _openTile(row, col - 1);
        _openTile(row, col + 1);
        _openTile(row - 1, col - 1);
        _openTile(row - 1, col);
        _openTile(row - 1, col + 1);
      }
    }
    return null;
  }

  /// Checks for surrounding mines and returns number of mines
  int checkMinesAround(int row, int col) {
    int rowLength = mineField.length;
    int colLength = mineField[0].length;

    int minesAround = 0;

    if (row - 1 >= 0) {
      // top-left
      if (col - 1 >= 0 && mineField[row - 1][col - 1].hasMine) {
        minesAround++;
      } // top
      if (mineField[row - 1][col].hasMine) {
        minesAround++;
      } // top-right
      if (col + 1 < colLength && mineField[row - 1][col + 1].hasMine) {
        minesAround++;
      }

      if (mineField[row - 1][col].visible == false) {
        mineField[row - 1][col].addBorder = 3;
      }
    }

    // left
    if (col - 1 >= 0) {
      if (mineField[row][col - 1].hasMine) {
        minesAround++;
      }
      if (mineField[row][col - 1].visible == false) {
        mineField[row][col - 1].addBorder = 2;
      }
    }
    // right
    if (col + 1 < colLength) {
      if (mineField[row][col + 1].hasMine) {
        minesAround++;
      }
      if (mineField[row][col + 1].visible == false) {
        mineField[row][col + 1].addBorder = 0;
      }
    }

    if (row + 1 < rowLength) {
      // bottom-left
      if (col - 1 >= 0 && mineField[row + 1][col - 1].hasMine) {
        minesAround++;
      } // bottom
      if (mineField[row + 1][col].hasMine) {
        minesAround++;
      } // bottom-right
      if (col + 1 < colLength && mineField[row + 1][col + 1].hasMine) {
        minesAround++;
      }
      if (mineField[row + 1][col].visible == false) {
        mineField[row + 1][col].addBorder = 1;
      }
    }

    return minesAround;
  }
}
