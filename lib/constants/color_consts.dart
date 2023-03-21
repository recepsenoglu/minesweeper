import 'package:flutter/material.dart';

class GameColors {
  static const Color _appBar = Color(0xFF547436);
  static const Color _homeScreenScaffold = Color(0xFF4AC0FD);

  static const Color _grassLight = Color(0xFFB3D665);
  static const Color _grassDark = Color(0xFFACD05E);

  static const Color _tileLight = Color(0xFFDFC3A3);
  static const Color _tileDark = Color(0xFFD2B99D);

  static const Color _tileBorder = Color(0xFF8FAE4D);

  static const Color _popupBackground = Color(0xFF4AC0FD);
  static const Color _popupPlayAgainButton = Color(0xFF547436);

  static const Color _valueText1 = Color(0xFF3874CB);
  static const Color _valueText2 = Color(0xFF508C46);
  static const Color _valueText3 = Color(0xFFC23F38);
  static const Color _valueText4 = Color(0xFF71279C);
  static const Color _valueText5 = Color(0xFFF09536);
  static const Color _valueText6 = Color(0xFFDA893D);
  static const Color _valueText7 = Color(0xFF000000);
  static const Color _valueText8 = Color(0xFFFF0000);

  static const Color _mine1 = Color(0xFFA94FEA);
  static const Color _mine2 = Color(0xFFE58A35);
  static const Color _mine3 = Color(0xFFDB52B1);
  static const Color _mine4 = Color(0xFF5783E6);
  static const Color _mine5 = Color(0xFFECC444);
  static const Color _mine6 = Color(0xFFCA423E);
  static const Color _mine7 = Color(0xFF7AE3EF);

  static Color get appBar => _appBar;
  static Color get homeScreenScaffold => _homeScreenScaffold;

  static Color get grassLight => _grassLight;
  static Color get grassDark => _grassDark;

  static Color get tileLight => _tileLight;
  static Color get tileDark => _tileDark;

  static Color get tileBorder => _tileBorder;

  static Color get popupBackground => _popupBackground;
  static Color get popupPlayAgainButton => _popupPlayAgainButton;

  static List<Color> get valueTextColors => [
        _valueText1,
        _valueText2,
        _valueText3,
        _valueText4,
        _valueText5,
        _valueText6,
        _valueText7,
        _valueText8
      ];

  static List<Color> get mineColors =>
      [_mine1, _mine2, _mine3, _mine4, _mine5, _mine6, _mine7];

  static Color darken(Color color, [double amount = .2]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}
