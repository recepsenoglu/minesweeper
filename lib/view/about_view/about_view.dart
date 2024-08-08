import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
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
    urlLauncherOnStateChanged = () {
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
        title: Text('about'.tr()),
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
                        'minesweeper'.tr(),
                        style: TextStyle(
                          fontSize: GameSizes.getWidth(0.06),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: GameSizes.getHeight(0.005)),
                      Text(
                        'version'.tr(args: ['1.0.4']),
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
                if (Platform.isAndroid)
                  OptionWidget(
                    title: 'moreGames'.tr(),
                    iconData: Icons.apps,
                    iconColor: Colors.red,
                    loading: urlLauncherLoading,
                    onTap: () async {
                      await launchURL(
                          'https://play.google.com/store/apps/dev?id=7235038440743748997');
                    },
                  ),
                OptionWidget(
                  title: 'developerWebsite'.tr(),
                  iconData: Icons.web,
                  iconColor: Colors.purple,
                  loading: urlLauncherLoading,
                  onTap: () async {
                    await launchURL('https://recepsenoglu.com/');
                  },
                ),
              ],
            ),
            OptionGroup(
              options: [
                OptionWidget(
                  title: 'privacyPolicy'.tr(),
                  iconData: Icons.privacy_tip,
                  iconColor: Colors.blue,
                  loading: urlLauncherLoading,
                  onTap: () async {
                    await launchURL(
                        'https://www.freeprivacypolicy.com/live/30009f95-7d04-4c58-b126-9ebb2d2acac8');
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
