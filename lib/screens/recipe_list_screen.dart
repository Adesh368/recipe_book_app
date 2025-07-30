// lib/screens/recipe_list_screen.dart

import 'package:flutter/material.dart';
import 'package:recipe_book_app/models/recipe.dart';
import 'package:recipe_book_app/screens/recipe_detail_screen.dart';

class RecipesListScreen extends StatelessWidget {
  final List<Recipe> recipes;
  final String title;

  const RecipesListScreen({
    Key? key,
    required this.recipes,
    this.title = 'All Recipes',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildRecipeCard(context, recipe),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRecipeCard(BuildContext context, Recipe recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RecipeDetailScreen(recipe: recipe),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: Row(
          children: [
            // Image section
            Container(
              width: 120,
              height: 100,
              child: Image.network(
                recipe.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            // Text section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  recipe.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
