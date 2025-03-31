import 'package:flutter/material.dart';
import 'package:pocker/services/system/model/image_usage.dart';

class ImageListCellName extends StatelessWidget {
  final ImageUsage image;

  const ImageListCellName({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            image.repository,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Text(
                image.shortId,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                image.tag,
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
