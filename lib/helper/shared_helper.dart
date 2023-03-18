import 'package:minesweeper/constants/game_consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  Future<int?> getRecord(GameMode gameMode) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(gameMode.name);
  }

  Future<bool> setRecord(GameMode gameMode, int time) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setInt(gameMode.name, time);
  }
}
