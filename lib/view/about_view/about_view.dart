import 'package:flutter/material.dart';

import '../../mixins/url_launcher_mixin.dart';
import '../../utils/game_colors.dart';
import '../../utils/game_sizes.dart';
import '../../widgets/option_group_widget.dart';
import '../../widgets/option_widget.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> with UrlLauncherMixin {
  @override
  void initState() {
    super.initState();
    onStateChanged = () {
      if (mounted) {
        setState(() {});
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColors.background,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('About'),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: GameSizes.getWidth(0.05),
        ),
      ),
      body: SingleChildScrollView(
        padding: GameSizes.getSymmetricPadding(0.05, 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: GameSizes.getSymmetricPadding(0.05, 0.02),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: GameSizes.getWidth(0.25),
                  ),
                  SizedBox(width: GameSizes.getWidth(0.05)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Minesweeper',
                        style: TextStyle(
                          fontSize: GameSizes.getWidth(0.06),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: GameSizes.getHeight(0.005)),
                      Text(
                        'Version 1.0.2',
                        style: TextStyle(
                          fontSize: GameSizes.getWidth(0.04),
                        ),
                      ),
                      SizedBox(height: GameSizes.getHeight(0.005)),
                      Text(
                        'Recep Oğuzhan Şenoğlu',
                        style: TextStyle(
                          fontSize: GameSizes.getWidth(0.04),
                        ),
                      ),
                      Text(
                        'İstanbul, Türkiye',
                        style: TextStyle(
                          fontSize: GameSizes.getWidth(0.035),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: GameSizes.getHeight(0.02)),
            OptionGroup(
              options: [
                OptionWidget(
                  title: 'More Games',
                  iconData: Icons.apps,
                  iconColor: Colors.red,
                  loading: loading,
                  onTap: () async {
                    await launchURL(
                        'https://play.google.com/store/apps/dev?id=7235038440743748997');
                  },
                ),
                OptionWidget(
                  title: 'Developer\'s Website',
                  iconData: Icons.web,
                  iconColor: Colors.purple,
                  loading: loading,
                  onTap: () async {
                    await launchURL('https://recepsenoglu.com/');
                  },
                ),
              ],
            ),
            OptionGroup(
              options: [
                OptionWidget(
                  title: 'Privacy Policy',
                  iconData: Icons.privacy_tip,
                  iconColor: Colors.blue,
                  loading: loading,
                  onTap: () async {
                    await launchURL(
                        'https://www.freeprivacypolicy.com/live/28f2fc39-d654-4609-8310-e11119fea1a6');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
