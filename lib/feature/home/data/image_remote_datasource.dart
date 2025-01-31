import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ImageRemoteDataSource {
  const ImageRemoteDataSource._();

  static Future<File> fetchRandomImage({http.Client? httpClient}) async {
    httpClient = httpClient ?? http.Client();
    final response = await httpClient
        .get(Uri.parse('https://coffee.alexflipnote.dev/random'));

    if (response.statusCode == 200) {
      final tempDir = await getTemporaryDirectory();
      final filePath =
          '${tempDir.path}/coffee_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      throw Exception("Failed to load image");
    }
  }
}
