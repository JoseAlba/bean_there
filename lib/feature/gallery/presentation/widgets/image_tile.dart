import 'dart:io';

import 'package:bean_there/feature/home/data/image_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ImageTile extends StatelessWidget {
  const ImageTile({
    super.key,
    required this.image,
  });

  final ImageModel image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/image/${image.id}'),
      child: Hero(
        tag: image.id,
        child: Image.file(
          File(image.filePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
