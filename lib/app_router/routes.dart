import 'package:bean_there/app_router/scaffold_with_nav_bar.dart';
import 'package:bean_there/gallery/gallery.dart';
import 'package:bean_there/home/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: navigatorKey,
  routes: [
    ShellRoute(
      builder: (_, __, child) {
        return ScaffoldWithNavBar(
          body: child,
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) {
            return HomePage();
          },
        ),
        GoRoute(
          path: '/gallery',
          builder: (_, __) {
            return GalleryPage();
          },
        ),
        GoRoute(
          path: '/favorites',
          builder: (_, __) {
            return FavoritesPage();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/image/:id',
      builder: (context, state) {
        final imageId = state.pathParameters['id']!;
        return ImagePage(imageId: imageId);
      },
    ),
  ],
);
