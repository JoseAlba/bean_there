import 'package:equatable/equatable.dart';

class GridState extends Equatable {
  final double currentScale;
  static const double minScale = 2.0;
  static const double maxScale = 5.0;

  const GridState({this.currentScale = 3.0});

  GridState copyWith({double? currentScale}) {
    return GridState(
      currentScale: currentScale ?? this.currentScale,
    );
  }

  @override
  List<Object> get props => [currentScale];
}
