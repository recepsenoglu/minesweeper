enum Images {
  stopwatch,
  trophy,
  bookmark,
  redCross,
  loseScreen,
  winScreen,
  homeScreenBg
}

extension ImagesExtension on Images {
  String get toPath => 'assets/images/$name.png';
}
