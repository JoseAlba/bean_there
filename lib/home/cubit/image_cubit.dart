import 'dart:io';
import 'dart:math';

import 'package:bean_there/app_router/routes.dart';
import 'package:bean_there/internationalization/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_repository/image_repository.dart';
import 'package:share_plus/share_plus.dart';

import 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(const ImageState()) {
    initialize();
  }

  Future<void> initialize() async {
    try {
      emit(state.copyWith(isLoading: true));
      await _loadCachedImages();
      await _loadRandomImages();
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to initialize images',
      ));
      _showNoInternetSnackBar();
    }
  }

  /// Load cached images or fetch new ones if none exist
  Future<void> _loadCachedImages() async {
    final images = await ImageUsecase.getImages();
    print(images.length);
    print(state.images.length);
    emit(state.copyWith(
      images: images,
      likedImages: images.where((img) => img.savedAt != null).toList(),
      favoriteImages:
          images.where((img) => img.savedAt != null && img.isFavorite).toList(),
    ));
  }

  /// Load cached images or fetch new ones if none exist
  Future<void> _loadRandomImages() async {
    final List<File> randomImages = state.randomImages;

    while (randomImages.length < 5) {
      await _loadRandomImage();
    }
  }

  /// Load new image & maintain a queue of 5 images
  Future<void> _loadRandomImage() async {
    final List<File> randomImages = [...state.randomImages];

    try {
      final image = await ImageUsecase.fetchRandomImage();
      randomImages.add(image);

      if (randomImages.length > 5) {
        randomImages.removeAt(0);
      }
    } catch (e) {
      if (randomImages.isEmpty) {
        _showNoInternetSnackBar();
      } else {
        randomImages.removeAt(0);
      }
    }
    emit(state.copyWith(randomImages: randomImages));
  }

  void toggleFavorite(ImageModel image) {
    final updatedImage = image.copyWith(isFavorite: !image.isFavorite);
    final updatedImages = state.images
        .map((img) => img.id == updatedImage.id ? updatedImage : img)
        .toList();

    ImageUsecase.updateImage(updatedImage);

    emit(state.copyWith(
      images: updatedImages,
      favoriteImages: updatedImages
          .where((img) => img.savedAt != null && img.isFavorite)
          .toList(),
    ));
  }

  /// Like an image & store it locally
  Future<void> likeImage(File image) async {
    await ImageUsecase.saveImageFile(image);
    await _loadCachedImages();
    await _loadRandomImage();

    final newLikeCount = state.likeCount + 1;
    emit(state.copyWith(likeCount: newLikeCount));

    if (newLikeCount % 5 == 0) {
      _showRandomCoffeePunSnackBar();
    }
  }

  /// Remove top cached image and load new image
  Future<void> dislikeImage() async {
    final List<File> randomImages = [...state.randomImages];
    randomImages.removeAt(0);
    emit(state.copyWith(randomImages: randomImages));

    await _loadRandomImage();
  }

  /// Share image to other platforms
  Future<void> shareImage(ImageModel image) async {
    final file = File(image.filePath);
    if (await file.exists()) {
      await Share.shareXFiles([XFile(image.filePath)]);
    }
  }

  void _showNoInternetSnackBar() {
    final context = navigatorKey.currentState!.context;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('No internet. Showing cached images.'),
        backgroundColor: Colors.amber,
      ),
    );
  }

  void _showRandomCoffeePunSnackBar() {
    final randomPun = _getRandomCoffeePun();
    final context = navigatorKey.currentState!.context;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          randomPun,
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.brown.shade700,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        action: SnackBarAction(
          label: "😆 More!",
          textColor: Colors.orangeAccent,
          onPressed: () => _showRandomCoffeePunSnackBar(),
        ),
      ),
    );
  }

  String _getRandomCoffeePun() {
    final context = navigatorKey.currentState!.context;
    int randomInt = Random().nextInt(7) + 1;
    switch (randomInt) {
      case 1:
        return Internationalization.of(context).coffeePun1;
      case 2:
        return Internationalization.of(context).coffeePun2;
      case 3:
        return Internationalization.of(context).coffeePun3;
      case 4:
        return Internationalization.of(context).coffeePun4;
      case 5:
        return Internationalization.of(context).coffeePun5;
      case 6:
      default:
        return Internationalization.of(context).coffeePun6;
    }
  }
}
