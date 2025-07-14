import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/recipe_list_screen.dart';
import '../../presentation/screens/recipe_detail_screen.dart';
import '../../presentation/screens/favorites_screen.dart';
import '../../presentation/screens/settings_screen.dart';
import '../../presentation/screens/log_export_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: '首页',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite),
                label: '收藏',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings),
                label: '设置',
              ),
            ],
            selectedIndex: _getSelectedIndex(state.uri.path),
            onDestinationSelected: (index) {
              switch (index) {
                case 0:
                  context.go('/home');
                  break;
                case 1:
                  context.go('/favorites');
                  break;
                case 2:
                  context.go('/settings');
                  break;
              }
            },
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) => const FavoritesScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/recipes',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        final ingredients = extra['ingredients'] as String? ?? '';
        final forceCulturalStory = extra['forceCulturalStory'] as bool? ?? false;
        
        return RecipeListScreen(
          ingredients: ingredients,
          forceCulturalStory: forceCulturalStory,
        );
      },
    ),
    GoRoute(
      path: '/recipe/:id',
      builder: (context, state) {
        final recipeId = state.pathParameters['id']!;
        return RecipeDetailScreen(recipeId: recipeId);
      },
    ),
    GoRoute(
      path: '/logs',
      builder: (context, state) => const LogExportScreen(),
    ),
  ],
);

int _getSelectedIndex(String path) {
  switch (path) {
    case '/home':
      return 0;
    case '/favorites':
      return 1;
    case '/settings':
      return 2;
    default:
      return 0;
  }
}
