import 'package:flutter/material.dart';

class DropdownIconButton extends StatelessWidget {
  final Widget icon;
  final List<PopupMenuItem<int>> items;
  final Function(int index) onSelected;

  const DropdownIconButton({
    super.key,
    required this.icon,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      tooltip: '',
      onSelected: (int index) => onSelected(index),
      itemBuilder: (BuildContext context) {
        return items;
      },
      icon: icon,
    );
  }
}
