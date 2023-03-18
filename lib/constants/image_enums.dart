enum Images { stopwatch, trophy, bookmark, loseScreen, winScreen }

extension ImagesExtension on Images {
  String get toPath => 'assets/images/$name.png';
}
