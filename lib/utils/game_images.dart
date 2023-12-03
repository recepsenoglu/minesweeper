enum Images {
  stopwatch,
  trophy,
  bookmark,
  redCross,
  loseScreen,
  winScreen,
  homeScreenBg,
  shovel,
}

extension ImagesExtension on Images {
  String get toPath => 'assets/images/$name.png';
}
