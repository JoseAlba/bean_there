import 'dart:io';

// import 'package:bean_there/home/cubit/image_controller.dart';
import 'package:bean_there/home/cubit/image_cubit.dart';
import 'package:bean_there/keys/keys.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final randomImages =
        context.select((ImageCubit cubit) => cubit.state.randomImages);

    return Center(
      child: InteractiveViewer(
        minScale: 0.5,
        maxScale: 4.0,
        child: randomImages.isEmpty
            ? SizedBox(
                height: 200,
                child: CoffeeProgressIndicator(),
              )
            : CoffeeSwiper(),
      ),
    );
  }
}

class CoffeeSwiper extends StatelessWidget {
  const CoffeeSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ImageCubit>();
    // final randomImages =
    //     context.select((ImageCubit cubit) => cubit.state.randomImages);

    // final imageState = context.select((ImageCubit cubit) => cubit.state);
    final currentImage = controller.state.randomImages[0];
    // final currentImage = imageState.randomImages[0];
    // final currentImage =
    //     context.select((ImageCubit cubit) => cubit.state.randomImages[0]);

    return Column(
      children: [
        Expanded(
          child: CardSwiper(
            cardsCount: controller.state.randomImages.length,
            numberOfCardsDisplayed: 1,
            onSwipe: (_, index, direction) async {
              if (direction == CardSwiperDirection.left) {
                await controller.dislikeImage();
                return true;
              } else if (direction == CardSwiperDirection.right) {
                await controller.likeImage(currentImage);
                return true;
              } else {
                return false;
              }
            },
            cardBuilder: (_, __, ___, ____) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(File(currentImage.path), fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                key: Keys.dislikeFab,
                heroTag: "dislike_fab",
                onPressed: () => controller.dislikeImage(),
                backgroundColor: Colors.red,
                child: const Icon(Icons.close),
              ),
              FloatingActionButton(
                key: Keys.likeFab,
                heroTag: "like_fab",
                onPressed: () => controller.likeImage(currentImage),
                backgroundColor: Colors.green,
                child: const Icon(Icons.favorite),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
