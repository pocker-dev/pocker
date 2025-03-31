import 'package:flutter/material.dart';

typedef MenuTapped = void Function(String name, String title);

class MenuItem {
  final String name;
  final String title;
  final List<MenuItem>? subItems;

  MenuItem(
    this.name, {
    required this.title,
    this.subItems,
  });

  Widget build(MenuTapped onTap, String selected, Color color) {
    if (subItems != null) {
      return ExpansionTile(
        title: Text(title),
        childrenPadding: const EdgeInsets.only(left: 10.0),
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
        ),
        collapsedShape: RoundedRectangleBorder(
          side: BorderSide.none,
        ),
        children: subItems!
            .map((item) => item.build(onTap, selected, color))
            .toList(),
      );
    }
    //
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: selected == name ? color : null,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: () {
            onTap(name, title);
          },
        ),
      ),
    );
  }
}
