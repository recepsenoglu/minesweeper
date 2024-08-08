import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper/helper/localization_manager.dart';
import 'package:minesweeper/mixins/url_launcher_mixin.dart';
import 'package:minesweeper/view/how_to_play_view/how_to_play_view.dart';

import '../../mixins/app_review_mixin.dart';
import '../../mixins/share_mixin.dart';
import '../../utils/exports.dart';
import '../../widgets/option_group_widget.dart';
import '../../widgets/option_widget.dart';
import '../about_view/about_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>
    with AppReviewMixin, ShareMixin, UrlLauncherMixin {
  @override
  void initState() {
    super.initState();
    shareOnStateChanged = () {
      setState(() {});
    };
    reviewOnStateChanged = () {
      setState(() {});
    };
    urlLauncherOnStateChanged = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColors.background,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('settings'.tr()),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: GameSizes.getWidth(0.05),
        ),
      ),
      body: SingleChildScrollView(
        padding: GameSizes.getSymmetricPadding(0.05, 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OptionGroup(
              options: [
                OptionWidget(
                  title: LocalizationManager.currentLanguageName,
                  iconData: Icons.language,
                  iconColor: Colors.blue,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('selectLanguage'.tr()),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: const Text('English'),
                              onTap: () {
                                LocalizationManager().changeLocale(
                                  context,
                                  const Locale('en', 'US'),
                                );
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('Türkçe'),
                              onTap: () {
                                LocalizationManager().changeLocale(
                                  context,
                                  const Locale('tr', 'TR'),
                                );
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            OptionGroup(options: [
              OptionWidget(
                title: 'howToPlay'.tr(),
                iconData: Icons.play_arrow,
                iconColor: Colors.green,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HowToPlayView(),
                      ));
                },
              ),
            ]),
            OptionGroup(
              options: [
                OptionWidget(
                  title: 'about'.tr(),
                  iconData: Icons.info,
                  iconColor: Colors.grey,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutView(),
                        ));
                  },
                ),
                if (Platform.isAndroid) ...[
                  OptionWidget(
                    title: 'rateUs'.tr(),
                    iconData: Icons.star,
                    iconColor: Colors.yellow,
                    loading: reviewLoading,
                    onTap: () async {
                      await openStoreListing();
                    },
                  ),
                  OptionWidget(
                    title: 'share'.tr(),
                    iconData: Icons.share,
                    iconColor: Colors.orange,
                    loading: shareLoading,
                    onTap: () async {
                      await shareApp('shareMessage'.tr(args: [
                        'https://play.google.com/store/apps/details?id=com.recepsenoglu.minesweeper'
                      ]));
                    },
                  ),
                ],
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
