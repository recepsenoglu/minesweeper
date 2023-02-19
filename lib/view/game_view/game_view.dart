import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minesweeper/constants/image_enums.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: _appBar(),
      body: Column(
        children: const [],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF547436),
      systemOverlayStyle: SystemUiOverlayStyle.light,
      centerTitle: true,
      leadingWidth: 100,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Images.bookmark.toPath),
          const SizedBox(width: 5),
          const Text("99"),
          const SizedBox(width: 15),
          Image.asset(Images.stopwatch.toPath, scale: 1.8),
          const SizedBox(width: 5),
          const Text("009"),
        ],
      ),
      actions: [
        SizedBox(
          width: 40,
          child: IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.volume_up),
            padding: EdgeInsets.zero,
            splashRadius: 25,
            iconSize: 35,
            onPressed: () {},
          ),
        ),
        SizedBox(
          width: 50,
          child: IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.close),
            padding: EdgeInsets.zero,
            splashRadius: 25,
            iconSize: 35,
            onPressed: () {},
          ),
        ),
      ],
      leading: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              " Hard",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Icon(
              Icons.arrow_drop_down_sharp,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
