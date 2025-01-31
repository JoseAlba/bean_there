import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class CoffeeProgressIndicator extends StatelessWidget {
  const CoffeeProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      'assets/animations/coffee_progress_indicator.riv',
      // 'packages/bean_there/assets/animations/coffee_progress_indicator.riv',
    );
  }
}
