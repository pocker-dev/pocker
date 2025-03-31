import 'package:flutter/material.dart';
import 'package:pocker/services/pod/model/pod_container_summary.dart';

class PodListCellTag extends StatelessWidget {
  final List<PodContainerSummary> containers;

  const PodListCellTag({super.key, required this.containers});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 3.0,
      children: [
        for (final container in containers)
          if (container.status.toLowerCase() == 'running')
            Tooltip(
              message: '${container.names}: ${container.status}',
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            )
          else
            Tooltip(
              message: '${container.names}: ${container.status}',
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            )
      ],
    );
  }
}
