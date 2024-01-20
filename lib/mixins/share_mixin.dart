import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

mixin ShareMixin<T extends StatefulWidget> on State<T> {
  bool shareLoading = false;
  void Function()? shareOnStateChanged;

  Future shareApp(String text) async {
    shareLoading = true;
    shareOnStateChanged?.call();
    await Share.share(text);
    await Future.delayed(const Duration(seconds: 2));
    shareLoading = false;
    shareOnStateChanged?.call();
  }
}
