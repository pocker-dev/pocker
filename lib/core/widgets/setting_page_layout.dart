import 'package:flutter/material.dart';

class SettingPageLayout extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final Widget content;

  const SettingPageLayout({
    super.key,
    required this.title,
    this.actions,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SelectableText(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            ...?actions,
          ],
        ),
        content,
      ],
    );
  }
}
