import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'utils/exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GameSizes.init(context);
    return MaterialApp(
      title: 'Minesweeper',
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: GameRoutes.generateRoute,
      initialRoute: GameRoutes.initialRoute,
      key: GameRoutes.navigatorKey,
    );
  }
}
