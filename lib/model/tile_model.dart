class Tile {
  late bool _visible;
  late bool _hasMine;
  late bool _hasFlag;
  late int _value;

  bool get visible => _visible;
  bool get hasMine => _hasMine;
  bool get hasFlag => _hasFlag;
  int get value => _value;

  set setMine(bool value) {
    _hasMine = value;
  }

  set changeVisibility(bool value) {
    _visible = value;
  }

  set setValue(int value) {
    _value = value;
  }

  Tile() {
    _visible = false;
    _hasMine = false;
    _hasFlag = false;
    _value = 0;
  }

  @override
  String toString() {
    return value.toString();
  }
}
