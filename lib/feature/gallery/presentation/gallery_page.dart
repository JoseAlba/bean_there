import 'package:bean_there/feature/gallery/presentation/widgets/image_tile.dart';
import 'package:bean_there/feature/home/presentation/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'grid_controller.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final gridController = Provider.of<GridController>(context);
    final imageController = Provider.of<ImageController>(context);
    return GestureDetector(
      onScaleUpdate: (ScaleUpdateDetails details) {
        gridController.updateScale(details.scale);
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridController.currentScale.round(),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: imageController.likedImages.length,
        itemBuilder: (context, index) {
          final image = imageController.likedImages[index];
          return ImageTile(
            key: Key('galleryItem$index'),
            image: image,
          );
        },
      ),
    );
  }
}
