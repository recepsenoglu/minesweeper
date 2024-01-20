import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

mixin AppReviewMixin<T extends StatefulWidget> on State<T> {
  bool reviewLoading = false;
  void Function()? reviewOnStateChanged;

  final InAppReview inAppReview = InAppReview.instance;

  Future openStoreListing() async {
    reviewLoading = true;
    reviewOnStateChanged?.call();
    await inAppReview.openStoreListing();
    reviewLoading = false;
    reviewOnStateChanged?.call();
  }
}
