import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:image_repository/image_repository.dart';

class ImageState extends Equatable {
  final List<ImageModel> images;
  final List<ImageModel> likedImages;
  final List<ImageModel> favoriteImages;
  final List<File> randomImages;
  final int likeCount;
  final bool isLoading;
  final String? errorMessage;

  const ImageState({
    this.images = const [],
    this.likedImages = const [],
    this.favoriteImages = const [],
    this.randomImages = const [],
    this.likeCount = 0,
    this.isLoading = false,
    this.errorMessage,
  });

  ImageState copyWith({
    List<ImageModel>? images,
    List<ImageModel>? likedImages,
    List<ImageModel>? favoriteImages,
    List<File>? randomImages,
    int? likeCount,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ImageState(
      images: images ?? this.images,
      likedImages: likedImages ?? this.likedImages,
      favoriteImages: favoriteImages ?? this.favoriteImages,
      randomImages: randomImages ?? this.randomImages,
      likeCount: likeCount ?? this.likeCount,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        images,
        likedImages,
        favoriteImages,
        randomImages,
        likeCount,
        isLoading,
        errorMessage
      ];
}
