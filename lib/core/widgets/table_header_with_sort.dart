import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

enum SortStyle {
  none,
  ascending,
  descending,
}

class TableHeaderWithSort extends StatefulWidget {
  const TableHeaderWithSort({
    super.key,
    required this.label,
    required this.sort,
    required this.onChanged,
  });

  final String label;
  final SortStyle? sort;
  final ValueChanged<SortStyle?> onChanged;

  @override
  State<TableHeaderWithSort> createState() => _TableHeaderWithSortState();
}

class _TableHeaderWithSortState extends State<TableHeaderWithSort> {
  @override
  Widget build(BuildContext context) {
    SortStyle sort = widget.sort ?? SortStyle.none;
    //
    Color upColor, downColor;
    switch (sort) {
      case SortStyle.ascending:
        upColor = Theme.of(context).colorScheme.onSurface;
        downColor = Colors.transparent;
      case SortStyle.descending:
        upColor = Colors.transparent;
        downColor = Theme.of(context).colorScheme.onSurface;
      default:
        upColor = Theme.of(context).colorScheme.secondary;
        downColor = Theme.of(context).colorScheme.secondary;
    }
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onChanged(sort),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Icon(
                    Symbols.arrow_drop_up,
                    weight: 500,
                    color: upColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Icon(
                    Symbols.arrow_drop_down,
                    weight: 500,
                    color: downColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
