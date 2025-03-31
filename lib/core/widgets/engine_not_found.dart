import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EngineNotFound extends StatelessWidget {
  String title;

  EngineNotFound({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SelectableText(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Expanded(
          child: Column(
            spacing: 10.0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/podman.png',
                width: 128,
                height: 128,
                cacheWidth: 128,
                cacheHeight: 128,
              ),
              SelectableText('no_engine'.tr()),
            ],
          ),
        )
      ],
    );
  }
}
