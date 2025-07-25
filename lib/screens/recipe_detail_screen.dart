import 'package:flutter/material.dart';
import 'package:recipe_book_app/models/recipe.dart';
import 'package:recipe_book_app/utils/responsive_breakpoints.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.isMobile(context);

    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                recipe.imageUrl,
                height: isMobile ? 200 : 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              recipe.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              recipe.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildInfoChip(Icons.timer, '${recipe.totalTimeMinutes} min'),
                const SizedBox(width: 8),
                _buildInfoChip(Icons.people, '${recipe.servings} servings'),
                const SizedBox(width: 8),
                _buildInfoChip(Icons.star, recipe.rating.toStringAsFixed(1)),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Instructions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              recipe.instructions.join('\n'),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(text),
      backgroundColor: Colors.orange[100],
    );
  }
}
