import 'package:flutter/material.dart';

class DetailSummaryRow extends StatelessWidget {
  final String name;
  final String value;

  const DetailSummaryRow({
    super.key,
    required this.name,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100.0,
          child: SelectableText(name),
        ),
        SelectableText(value),
      ],
    );
  }
}
