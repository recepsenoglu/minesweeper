class Tile {
  late bool _visible;
  late bool _hasMine;
  late bool _hasFlag;
  late int _value;
  late List<int> _offset;

  bool get visible => _visible;
  bool get hasMine => _hasMine;
  bool get hasFlag => _hasFlag;
  int get value => _value;
  List<int> get offSet => _offset;
  int get row => _offset[0];
  int get col => _offset[1];

  set setVisible(bool value) {
    _visible = value;
  }

  set setMine(bool value) {
    _hasMine = value;
  }

  set setFlag(bool value) {
    _hasFlag = value;
  }

  set setValue(int value) {
    _value = value;
    _visible = true;
  }

  set setOffset(List<int> value) {
    _offset = value;
  }

  Tile(int row, int col) {
    _visible = false;
    _hasMine = false;
    _hasFlag = false;
    _value = -1;
    _offset = [row, col];
  }

  @override
  String toString() {
    return value.toString();
  }
}
