import 'package:flutter/material.dart';

import 'app_bar.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const StatsAppBar(),
        body: TabBarView(children: [
          Icon(Icons.abc),
          Icon(Icons.abc),
          Icon(Icons.abc),
        ]),
      ),
    );
  }
}
