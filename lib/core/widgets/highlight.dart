import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/dracula.dart';
import 'package:highlight/highlight.dart';

class Highlight extends StatelessWidget {
  final Mode language;
  final String text;

  const Highlight({
    super.key,
    required this.language,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return CodeTheme(
      data: CodeThemeData(styles: isDarkMode ? draculaTheme : githubTheme),
      child: SingleChildScrollView(
        child: CodeField(
          readOnly: true,
          controller: CodeController(
            readOnly: true,
            text: text,
            language: language,
          ),
          textStyle: const TextStyle(
            fontSize: 14.0,
            height: 1.5,
          ),
          background: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
