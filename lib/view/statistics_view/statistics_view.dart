import 'package:flutter/material.dart';

import 'app_bar.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: StatsAppBar(),
    );
  }
}
