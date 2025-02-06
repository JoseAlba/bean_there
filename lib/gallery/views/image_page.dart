import 'dart:io';

import 'package:bean_there/home/home.dart';
import 'package:bean_there/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({
    super.key,
    required this.imageId,
  });

  final String imageId;

  @override
  Widget build(BuildContext context) {
    final imageController = context.watch<ImageCubit>();
    final image =
        imageController.state.images.firstWhere((i) => i.id == imageId);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            key: Keys.favoriteButton,
            icon: Icon(
              image.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: image.isFavorite ? Colors.red : Colors.white,
            ),
            // onPressed: null,
            onPressed: () => imageController.toggleFavorite(image),
          ),
          IconButton(
            key: Keys.shareImageButton,
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () => imageController.shareImage(image),
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: Hero(
            tag: image.id,
            child: Image.file(
              File(image.filePath),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
