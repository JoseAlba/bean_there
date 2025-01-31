import 'package:flutter/material.dart';

class Keys {
  const Keys._();

  // Navigation bar buttons
  static const navigationBarHome = Key('navigationBarHome');
  static const navigationBarGallery = Key('navigationBarGallery');
  static const navigationBarFavorites = Key('navigationBarFavorites');

  // Like and dislike fab buttons in home page
  static const likeFab = Key('likeFab');
  static const dislikeFab = Key('dislikeFab');

  // Buttons in image page
  static const shareImageButton = Key('shareImageButton');
  static const favoriteButton = Key('favoriteButton');
}
