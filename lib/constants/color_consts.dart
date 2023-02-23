import 'package:flutter/material.dart';

class GameColors {
  static const Color _grassLight = Color(0xFFB3D665);
  static const Color _grassDark = Color(0xFFACD05E);

  static const Color _mine1 = Color(0xFFA94FEA);
  static const Color _mine2 = Color(0xFFE58A35);
  static const Color _mine3 = Color(0xFFDB52B1);
  static const Color _mine4 = Color(0xFF5783E6);
  static const Color _mine5 = Color(0xFFECC444);
  static const Color _mine6 = Color(0xFFCA423E);
  static const Color _mine7 = Color(0xFF7AE3EF);

  static Color get grassLight => _grassLight;
  static Color get grassDark => _grassDark;

  static List<Color> get mineColors =>
      [_mine1, _mine2, _mine3, _mine4, _mine5, _mine6, _mine7];

  static Color darken(Color color, [double amount = .2]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}
