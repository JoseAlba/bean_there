import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: CoffeeProgressIndicator)
Widget coffeeProgressIndicatorDemo(BuildContext context) {
  final color = context.knobs.color(
    label: 'Color',
    initialValue: Theme.of(context).colorScheme.primaryContainer,
  );
  final size = context.knobs.double.slider(
    label: 'Size',
    initialValue: 200,
    min: 100,
    max: 400,
  );
  return Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
    // color: Colors.red,
    child: CoffeeProgressIndicator(),
  );
}
