import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pocker/views/containers/model/container_group.dart';

class ContainerListCellPodName extends StatelessWidget {
  final ContainerGroup group;

  const ContainerListCellPodName({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            group.displayTitle(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'pod_containers_label'.plural(group.containers.length),
            style: TextStyle(
              fontSize: 12.0,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
