enum Audio {
  win,
  lose,
  putFlag,
  removeFlag,
  lastHit,
  clickEmpty,
  clickOne,
  clickTwo,
  clickThree,
  clickFour,
  blue,
  pink,
  purple,
}

extension AudioExtension on Audio {
  String get toPath => 'assets/audio/$name.wav';
}

class GameAudios {
  static const Audio _win = Audio.win;
  static const Audio _lose = Audio.lose;
  static const Audio _putFlag = Audio.putFlag;
  static const Audio _removeFlag = Audio.removeFlag;
  static const Audio _lastHit = Audio.lastHit;
  static const Audio _clickEmpty = Audio.clickEmpty;
  static const Audio _clickOne = Audio.clickOne;
  static const Audio _clickTwo = Audio.clickTwo;
  static const Audio _clickThree = Audio.clickThree;
  static const Audio _clickFour = Audio.clickFour;

  static const Audio _blue = Audio.blue;
  static const Audio _pink = Audio.pink;
  static const Audio _purple = Audio.purple;

  static Audio get win => _win;
  static Audio get lose => _lose;
  static Audio get putFlag => _putFlag;
  static Audio get removeFlag => _removeFlag;
  static Audio get lastHit => _lastHit;

  static List<Audio> get clickSounds =>
      [_clickEmpty, _clickOne, _clickTwo, _clickThree, _clickFour];

  static List<Audio> get mineSound => [_purple, _blue, _pink];
}
