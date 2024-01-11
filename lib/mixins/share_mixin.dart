import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

mixin ShareMixin<T extends StatefulWidget> on State<T> {
  bool shareLoading = false;
  void Function()? onStateChanged;

  Future shareApp() async {
    shareLoading = true;
    onStateChanged?.call();
    await Share.share(
      'Check out this awesome Minesweeper game! \n\n' 
        'https://play.google.com/store/apps/details?id=com.recepsenoglu.minesweeper');
    await Future.delayed(const Duration(seconds: 2));
    shareLoading = false;
    onStateChanged?.call();
  }
}
