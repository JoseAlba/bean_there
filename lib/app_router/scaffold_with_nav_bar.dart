import 'package:bean_there/home/home.dart';
import 'package:bean_there/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    final imageState = context.select((ImageCubit cubit) => cubit.state);

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
              isLabelVisible: imageState.likedImages.isNotEmpty,
              label: Text(imageState.likedImages.length.toString()),
              child: Icon(Icons.photo_album),
            ),
            label: 'Gallery',
          ),
          NavigationDestination(
            key: Keys.navigationBarFavorites,
            icon: Badge(
              isLabelVisible: imageState.favoriteImages.isNotEmpty,
              label: Text(imageState.favoriteImages.length.toString()),
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
