import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

mixin UrlLauncherMixin<T extends StatefulWidget> on State<T> {
  bool urlLauncherLoading = false;
  void Function()? urlLauncherOnStateChanged;

  Future launchURL(String url) async {
    urlLauncherLoading = true;
    urlLauncherOnStateChanged?.call();
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch $url');
    }
    urlLauncherLoading = false;
    urlLauncherOnStateChanged?.call();
  }
}
