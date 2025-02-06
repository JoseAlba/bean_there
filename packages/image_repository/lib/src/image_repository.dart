import 'dart:io';

import 'package:image_repository/src/datasources/image_local_datasource.dart';
import 'package:image_repository/src/datasources/image_remote_datasource.dart';
import 'package:image_repository/src/models/image_model.dart';

class ImageUsecase {
  const ImageUsecase._();

  static Future<File> fetchRandomImage() async {
    return await ImageRemoteDataSource.fetchRandomImage();
  }

  static Future<List<ImageModel>> getImages() async {
    return await ImageLocalDatasource.getImages();
  }

  static Future<void> updateImage(ImageModel imageModel) async {
    return await ImageLocalDatasource.updateImage(imageModel);
  }

  static Future<void> saveImageFile(File image) async {
    return await ImageLocalDatasource.saveImageFile(image);
  }
}
