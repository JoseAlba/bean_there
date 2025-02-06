import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$lightTheme', () {
    test('uses material 3', () {
      expect(lightTheme.useMaterial3, isTrue);
    });
  });
}
