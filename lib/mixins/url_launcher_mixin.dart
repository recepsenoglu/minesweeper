import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

mixin UrlLauncherMixin<T extends StatefulWidget> on State<T> {
  bool loading = false;
  void Function()? onStateChanged;

  Future launchURL(String url) async {
    loading = true;
    onStateChanged?.call();
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch $url');
    }
    loading = false;
    onStateChanged?.call();
  }
}
