import 'dart:convert';
import 'dart:io';

import 'package:image_repository/src/models/image_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ImageLocalDatasource {
  const ImageLocalDatasource._();

  static const _cachedImagesKey = 'cached_images';

  static Future<List<ImageModel>> getImages() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(_cachedImagesKey);

    if (jsonList == null || jsonList.isEmpty) return [];

    return jsonList
        .map((json) => ImageModel.fromJson(jsonDecode(json)))
        .where((imageModel) => File(imageModel.filePath).existsSync())
        .toList();
  }

  static Future<void> updateImage(ImageModel updatedModel) async {
    final images = await getImages();
    final index = images.indexWhere((image) => image.id == updatedModel.id);
    if (index != -1) {
      images[index] = updatedModel;
      await _saveImages(images);
    }
  }

  static Future<void> saveImageFile(File image) async {
    final now = DateTime.now();

    final directory = await getApplicationDocumentsDirectory();
    final imageDir = Directory('${directory.path}/coffee_images');
    await imageDir.create(recursive: true);

    final savedFilePath =
        '${imageDir.path}/coffee_${now.millisecondsSinceEpoch}.jpg';
    final savedFile = File(savedFilePath);
    await savedFile.writeAsBytes(await image.readAsBytes());

    final savedModel = ImageModel(
      id: Uuid().v4(),
      filePath: savedFile.path,
      savedAt: now,
    );
    final images = await getImages();
    final isDuplicate =
        images.any((img) => img.filePath == savedModel.filePath);
    if (!isDuplicate) {
      images.add(savedModel);
      await _saveImages(images);
    }
  }

  static Future<void> _saveImages(List<ImageModel> images) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList =
        images.map((imageModel) => jsonEncode(imageModel.toJson())).toList();
    await prefs.setStringList(_cachedImagesKey, jsonList);
  }
}
