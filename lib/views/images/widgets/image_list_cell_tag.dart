import 'package:flutter/material.dart';

class ImageListCellTag extends StatelessWidget {
  final String tag;

  const ImageListCellTag(this.tag, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.only(left: 3.0),
          child: SelectableText(tag),
        ),
      ],
    );
  }
}
