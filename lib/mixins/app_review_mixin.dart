import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

mixin AppReviewMixin<T extends StatefulWidget> on State<T> {
  bool reviewLoading = false;
  void Function()? onStateChanged;

  final InAppReview inAppReview = InAppReview.instance;

  Future openStoreListing() async {
    reviewLoading = true;
    onStateChanged?.call();
    await inAppReview.openStoreListing();
    reviewLoading = false;
    onStateChanged?.call();
  }
}
