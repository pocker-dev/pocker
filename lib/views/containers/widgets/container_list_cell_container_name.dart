import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pocker/services/container/model/container_summary.dart';

class ContainerListCellContainerName extends StatelessWidget {
  final ContainerSummary container;

  const ContainerListCellContainerName({super.key, required this.container});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            container.names[0],
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            spacing: 5.0,
            children: [
              Text(
                container.state.toUpperCase(),
                style: TextStyle(
                  fontSize: 12.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              if (container.ports != null && container.ports!.isNotEmpty)
                Text(
                  'container_table_row_ports'.plural(container.ports!.length,
                      args: [
                        container.ports!
                            .map((port) => port.hostPort.toString())
                            .join(',')
                      ]),
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
