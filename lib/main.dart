import 'package:bean_there/app_router/routes.dart';
import 'package:bean_there/home/home.dart';
import 'package:bean_there/internationalization/internationalization.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'gallery/gallery.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BeanThereApp());
}

class BeanThereApp extends StatelessWidget {
  const BeanThereApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ImageCubit()),
        BlocProvider(create: (_) => GridCubit()),
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
