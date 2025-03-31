import 'package:flutter/material.dart';

enum CircularProgressSize {
  small,
  middle,
  large,
}

class CircularProgress extends StatefulWidget {
  final CircularProgressSize size;
  final double value;

  final String? title;
  final String? subtitle;
  final String? tooltip;

  const CircularProgress({
    super.key,
    required this.size,
    required this.value,
    this.title,
    this.subtitle,
    this.tooltip,
  });

  @override
  State<CircularProgress> createState() => _CircularProgressState();
}

class _CircularProgressState extends State<CircularProgress> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip ?? '',
      waitDuration: Duration(seconds: 2),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: widget.size == CircularProgressSize.large
                ? 80
                : widget.size == CircularProgressSize.middle
                    ? 60
                    : 40,
            height: widget.size == CircularProgressSize.large
                ? 80
                : widget.size == CircularProgressSize.middle
                    ? 60
                    : 40,
            child: CircularProgressIndicator(
              value: widget.value.isInfinite || widget.value.isNaN
                  ? 0
                  : widget.value,
              strokeWidth: widget.size == CircularProgressSize.large
                  ? 3.0
                  : widget.size == CircularProgressSize.middle
                      ? 2.0
                      : 1.0,
              color: widget.value < 0.6
                  ? Colors.green
                  : widget.value < 0.9
                      ? Colors.orange
                      : Colors.red,
              backgroundColor: Theme.of(context).colorScheme.outline,
            ),
          ),
          Column(
            children: [
              widget.title != null
                  ? SelectableText(
                      widget.title!,
                      style: TextStyle(
                        fontSize: widget.size == CircularProgressSize.large
                            ? 14
                            : widget.size == CircularProgressSize.middle
                                ? 10
                                : 8,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    )
                  : SizedBox.shrink(),
              widget.subtitle != null
                  ? SelectableText(
                      widget.subtitle!,
                      style: TextStyle(
                        fontSize: widget.size == CircularProgressSize.large
                            ? 12
                            : widget.size == CircularProgressSize.middle
                                ? 8
                                : 6,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
