import 'package:flutter/material.dart';
import 'package:recipe_book_app/screens/home_screen.dart';
import 'package:recipe_book_app/screens/recipe_detail_screen.dart';
import 'package:recipe_book_app/models/recipe.dart';
import 'package:recipe_book_app/widgets/common/responsive_navigation.dart';

class RouteGenerator {
  static const String home = '/';
  static const String recipeDetail = '/recipe_detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const ResponsiveNavigation());

      case recipeDetail:
        if (settings.arguments is Recipe) {
          final recipe = settings.arguments as Recipe;
          return MaterialPageRoute(
            builder: (_) => RecipeDetailScreen(recipe: recipe),
          );
        }
        return _errorRoute('Invalid or missing recipe argument');

      default:
        return _errorRoute('Route not found: ${settings.name}');
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Text(message, style: const TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
