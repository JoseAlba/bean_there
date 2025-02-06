import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:image_repository/image_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'image_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('ImageRemoteDataSource', () {
    test('fetchRandomImage throws exception on non-200 response', () async {
      // Arrange
      final mockHttpClient = MockClient();

      when(
        mockHttpClient.get(Uri.parse('https://coffee.alexflipnote.dev/random')),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      // Assert
      expect(
          () => ImageRemoteDataSource.fetchRandomImage(
              httpClient: mockHttpClient),
          throwsException);
    });
  });
}
