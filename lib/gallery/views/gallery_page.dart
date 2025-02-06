import 'package:bean_there/gallery/gallery.dart';
import 'package:bean_there/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final gridController = context.watch<GridCubit>();
    final imageController = context.watch<ImageCubit>();

    return GestureDetector(
      onScaleUpdate: (ScaleUpdateDetails details) {
        gridController.updateScale(details.scale);
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridController.state.currentScale.round(),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: imageController.state.likedImages.length,
        itemBuilder: (context, index) {
          final image = imageController.state.likedImages[index];
          return ImageTile(
            key: Key('galleryItem$index'),
            image: image,
          );
        },
      ),
    );
  }
}
