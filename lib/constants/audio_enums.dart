enum Audio {
  click,
  dig,
  win,
}

extension AudioExtension on Audio {
  String get toPath => 'assets/audio/$name.wav';
}
