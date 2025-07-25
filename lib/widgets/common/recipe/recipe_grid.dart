import 'package:flutter/material.dart';
import 'package:recipe_book_app/models/recipe.dart';
import 'package:recipe_book_app/utils/responsive_breakpoints.dart';
import 'package:recipe_book_app/widgets/common/recipe/recipe_card.dart';


class ResponsiveRecipeGrid extends StatelessWidget {
  final List<Recipe> recipes;
  final int maxItems;

  const ResponsiveRecipeGrid({
    Key? key,
    required this.recipes,
    this.maxItems = 6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = ResponsiveBreakpoints.isTablet(context) ? 3 : 2;
    final displayedRecipes = recipes.take(maxItems).toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: displayedRecipes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final recipe = displayedRecipes[index];
        return ResponsiveRecipeCard(
          recipe: recipe,
          onTap: () {
            // You can add navigation to details page here
          },
        );
      },
    );
  }
}
