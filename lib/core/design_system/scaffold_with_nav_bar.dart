import 'package:bean_there/core/keys/keys.dart';
import 'package:bean_there/feature/home/presentation/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ImageController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bean There'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (index) => _onItemTapped(index, context),
        destinations: [
          NavigationDestination(
            key: Keys.navigationBarHome,
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            key: Keys.navigationBarGallery,
            icon: Badge(
              isLabelVisible: controller.likedImages.isNotEmpty,
              label: Text(controller.likedImages.length.toString()),
              child: Icon(Icons.photo_album),
            ),
            label: 'Gallery',
          ),
          NavigationDestination(
            key: Keys.navigationBarFavorites,
            icon: Badge(
              isLabelVisible: controller.favoriteImages.isNotEmpty,
              label: Text(controller.favoriteImages.length.toString()),
              child: Icon(Icons.favorite),
            ),
            label: 'Favorites',
          ),
        ],
      ),
      body: body,
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/gallery')) {
      return 1;
    }
    if (location.startsWith('/favorites')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/gallery');
        break;
      case 2:
        context.go('/favorites');
        break;
    }
  }
}
