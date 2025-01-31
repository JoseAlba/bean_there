import 'package:bean_there/core/design_system/theme.dart';
import 'package:bean_there/core/internationalization/internationalization.dart';
import 'package:bean_there/core/routes/routes.dart';
import 'package:bean_there/feature/gallery/presentation/grid_controller.dart';
import 'package:bean_there/feature/home/presentation/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BeanThereApp());
}

class BeanThereApp extends StatelessWidget {
  const BeanThereApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ImageController>(
          create: (_) => ImageController(),
        ),
        ChangeNotifierProvider<GridController>(
          create: (_) => GridController(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Bean There',
        localizationsDelegates: Internationalization.localizationsDelegates,
        supportedLocales: Internationalization.supportedLocales,
        theme: lightTheme,
        darkTheme: darkTheme,
        routerConfig: router,
      ),
    );
  }
}
