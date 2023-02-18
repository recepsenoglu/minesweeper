enum Images { stopwatch, bookmark }

extension ImagesExtension on Images {
  String get toPath => 'assets/images/$name.png';
}
