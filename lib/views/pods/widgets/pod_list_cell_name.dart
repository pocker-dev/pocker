import 'package:flutter/material.dart';
import 'package:pocker/services/pod/model/pod_summary.dart';

class PodListCellName extends StatelessWidget {
  final PodSummary info;

  const PodListCellName({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            info.name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Text(
                info.shortId,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
