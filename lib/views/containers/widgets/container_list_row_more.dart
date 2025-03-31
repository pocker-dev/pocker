import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ContainerListRowMore extends StatefulWidget {
  final ValueChanged<bool> onTap;

  const ContainerListRowMore({super.key, required this.onTap});

  @override
  State<ContainerListRowMore> createState() => _ContainerListRowMoreState();
}

class _ContainerListRowMoreState extends State<ContainerListRowMore> {
  bool _collapsed = true;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: Icon(
          _collapsed
              ? Symbols.keyboard_arrow_right
              : Symbols.keyboard_arrow_down,
        ),
        onTap: () => {
          setState(() {
            _collapsed = !_collapsed;
            widget.onTap(_collapsed);
          }),
        },
      ),
    );
  }
}
