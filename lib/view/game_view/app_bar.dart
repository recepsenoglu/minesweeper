import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/image_enums.dart';

class GameAppBar extends StatelessWidget with PreferredSizeWidget {
  const GameAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF547436),
      systemOverlayStyle: SystemUiOverlayStyle.light,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          DifficultySettings(),
          Spacer(),
          Flags(),
          SizedBox(width: 15),
          Stopwatch(),
          Spacer(),
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
    );
  }
}

class Stopwatch extends StatelessWidget {
  const Stopwatch({super.key});

  @override
  Widget build(BuildContext context) {
    String timePassed = "009";
    return Row(
      children: [
        Image.asset(Images.stopwatch.toPath, scale: 1.8),
        const SizedBox(width: 5),
        Text(timePassed),
      ],
    );
  }
}

class Flags extends StatelessWidget {
  const Flags({super.key});

  @override
  Widget build(BuildContext context) {
    String flagCount = "99";
    return Row(
      children: [
        Image.asset(Images.bookmark.toPath),
        const SizedBox(width: 5),
        Text(flagCount),
      ],
    );
  }
}

class DifficultySettings extends StatefulWidget {
  const DifficultySettings({super.key});

  @override
  State<DifficultySettings> createState() => _DifficultySettingsState();
}

class _DifficultySettingsState extends State<DifficultySettings> {
  String mode = 'Easy';
  List<String> modes = ['Easy', 'Medium', 'Hard'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      margin: const EdgeInsets.symmetric(vertical: 10).copyWith(left: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: DropdownButton<String>(
          value: mode,
          isDense: true,
          underline: const SizedBox(),
          items: modes.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(" $value"),
            );
          }).toList(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16,
          ),
          onChanged: (value) {
            setState(() {
              mode = value.toString();
            });
          },
        ),
      ),
    );
  }
}
