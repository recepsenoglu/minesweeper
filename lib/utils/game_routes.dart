import 'package:flutter/material.dart';
import 'package:minesweeper/view/about_view/about_view.dart';
import 'package:minesweeper/view/home_view/home_view.dart';
import 'package:minesweeper/view/statistics_view/statistics_view.dart';

class GameRoutes {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String initialRoute = '/';
  static const String gameView = '/game_view';
  static const String statisticsView = '/statistics_view';
  static const String aboutView = '/about_view';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());

      case gameView:
        return MaterialPageRoute(builder: (_) => const HomeView());

      case statisticsView:
        return MaterialPageRoute(builder: (_) => const StatisticsView());

      case aboutView:
        return MaterialPageRoute(builder: (_) => const AboutView());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }

  static Future<dynamic> goTo(String routeName,
      {bool enableBack = false, Object? arguments}) async {
    return await Navigator.of(navigatorKey.currentContext!)
        .pushNamedAndRemoveUntil(
      routeName,
      arguments: arguments,
      (route) => enableBack,
    );
  }

  static Future<dynamic> pop({bool returnDialog = false}) async {
    return Navigator.of(navigatorKey.currentContext!).pop(returnDialog);
  }
}
