import 'package:flutter/material.dart';

class GridController with ChangeNotifier {
  double _currentScale = 3.0;
  static const double _minScale = 2.0;
  static const double _maxScale = 5.0;

  double get currentScale => _currentScale;

  void updateScale(double scale) {
    _currentScale = (_currentScale * scale).clamp(_minScale, _maxScale);
    notifyListeners();
  }
}
