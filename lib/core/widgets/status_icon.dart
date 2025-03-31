import 'package:flutter/material.dart';

class StatusIcon extends StatelessWidget {
  final IconData icon;
  final double? size;

  /// Status
  ///
  /// Container.decoration:
  /// - 0: Theme.of(context).colorScheme.onSurface
  /// - 1: Theme.of(context).colorScheme.primary
  /// - 2: Theme.of(context).colorScheme.secondary
  ///
  /// Container.color:
  /// - 0: Colors.transparent
  /// - 1: Theme.of(context).colorScheme.primary
  /// - 2: Theme.of(context).colorScheme.secondary
  ///
  /// Icon Color:
  /// - 0: null
  /// - 1 & 2: Theme.of(context).colorScheme.surface
  final int status;
  final String tooltip;
  final bool iconFill;

  const StatusIcon(
    this.icon, {
    super.key,
    this.size,
    this.status = 0,
    this.tooltip = '',
    this.iconFill = true,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      waitDuration: Duration(seconds: 2),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            color: status == 0
                ? Theme.of(context).colorScheme.onSurface
                : status == 1
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
          ),
          color: status == 0
              ? Colors.transparent
              : status == 1
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: EdgeInsets.all(2.0),
        child: Icon(
          icon,
          fill: iconFill ? 1 : 0,
          size: size,
          color: status == 0 ? null : Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
