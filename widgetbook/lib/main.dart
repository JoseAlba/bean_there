import 'package:bean_there/core/design_system/theme.dart';
import 'package:bean_there/core/internationalization/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgetbook/widgetbook.dart' hide AccessibilityAddon;
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// This file does not exist yet,
// it will be generated in the next step
import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      appBuilder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          useInheritedMediaQuery: true,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: Internationalization.localizationsDelegates,
            supportedLocales: Internationalization.supportedLocales,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: child,
          ),
        );
      },
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light',
              data: lightTheme,
            ),
            WidgetbookTheme(
              name: 'Dark',
              data: darkTheme,
            ),
          ],
        ),
        TextScaleAddon(
          min: 1.0,
          max: 4.0,
        ),
        LocalizationAddon(
          locales: Internationalization.supportedLocales,
          localizationsDelegates: Internationalization.localizationsDelegates,
        ),
        DeviceFrameAddon(
          devices: [
            Devices.ios.iPhoneSE,
            Devices.ios.iPhone13,
          ],
        ),
        AlignmentAddon(
          initialAlignment: Alignment.center,
        ),
        InspectorAddon(enabled: true),
        TimeDilationAddon(),
        ZoomAddon(initialZoom: 1.0),
        // AccessibilityAddon(),
      ],
      directories: directories,
    );
  }
}
