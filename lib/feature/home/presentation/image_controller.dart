import 'dart:io';
import 'dart:math';

import 'package:bean_there/core/internationalization/internationalization.dart';
import 'package:bean_there/core/routes/routes.dart';
import 'package:bean_there/feature/home/data/image_model.dart';
import 'package:bean_there/feature/home/data/image_usecase.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ImageController extends ChangeNotifier {
  List<ImageModel> images = [];

  List<ImageModel> get likedImages =>
      images.where((imageModel) => imageModel.savedAt != null).toList();

  List<ImageModel> get favoriteImages => images
      .where(
          (imageModel) => imageModel.savedAt != null && imageModel.isFavorite)
      .toList();

  List<File> randomImages = [];
  int likeCount = 0;

  ImageController() {
    _initialize();
  }

  /// Initialize: Preload 5 images & fetch liked images
  Future<void> _initialize() async {
    await _loadCachedImages();
    await _loadRandomImages();
  }

  /// Load images from storage and/or fetch new ones if required
  Future<void> _loadCachedImages() async {
    images = await ImageUsecase.getImages();
    notifyListeners();
  }

  /// Load cached images or fetch new ones if none exist
  Future<void> _loadRandomImages() async {
    while (randomImages.length < 5) {
      await _loadRandomImage();
    }
  }

  /// Load new image & maintain a queue of 5 images
  Future<void> _loadRandomImage() async {
    try {
      final image = await ImageUsecase.fetchRandomImage();
      randomImages.add(image);

      if (randomImages.length > 5) {
        randomImages.removeAt(0);
      }
      notifyListeners();
    } catch (e) {
      if (randomImages.isEmpty) {
        _showNoInternetSnackBar();
      } else {
        randomImages.removeAt(0);
        notifyListeners();
      }
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

  /// Toggle isFavorite for [ImageModel].
  Future<void> toggleFavorite(ImageModel image) async {
    updateImage(image.copyWith(isFavorite: !image.isFavorite));
  }

  /// Update an image model
  void updateImage(ImageModel updatedImage) {
    final index = images.indexWhere((img) => img.id == updatedImage.id);
    if (index != -1) {
      images[index] = updatedImage;
      ImageUsecase.updateImage(updatedImage);
      notifyListeners();
    }
  }

  /// Like an image & store it locally
  Future<void> likeImage(File image) async {
    await ImageUsecase.saveImageFile(image);

    await _loadCachedImages();
    await _loadRandomImage();

    likeCount++;
    if (likeCount % 5 == 0) {
      _showRandomCoffeePunSnackBar();
    }
  }

  void _showRandomCoffeePunSnackBar() {
    final randomPun = getRandomCoffeePun();
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

  String getRandomCoffeePun() {
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

  /// Remove top cached image and load new image
  Future<void> dislikeImage() async {
    await _loadRandomImage();
  }

  /// Share image to other platforms
  Future<void> shareImage(ImageModel imageModel) async {
    final file = File(imageModel.filePath);
    if (await file.exists()) {
      await Share.shareXFiles([XFile(imageModel.filePath)]);
    }
  }
}
