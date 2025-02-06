import 'package:flutter_bloc/flutter_bloc.dart';

import 'grid_state.dart';

class GridCubit extends Cubit<GridState> {
  GridCubit() : super(const GridState());

  void updateScale(double scale) {
    final newScale = (state.currentScale * scale).clamp(
      GridState.minScale,
      GridState.maxScale,
    );
    emit(state.copyWith(currentScale: newScale));
  }
}
