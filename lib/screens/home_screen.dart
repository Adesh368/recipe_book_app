// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:recipe_book_app/data/sample_recipes.dart';
import 'package:recipe_book_app/utils/responsive_breakpoints.dart';
import 'package:recipe_book_app/widgets/common/recipe/recipe_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(context),
            const SizedBox(height: 32),
            _buildFeaturedRecipes(context),
            const SizedBox(height: 32),
            _buildQuickCategories(context),
            const SizedBox(height: 32),
            _buildRecentlyViewed(context),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Recipe Book'),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => _showSearch(context),
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () => _navigateToShoppingList(context),
        ),
      ],
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: ResponsiveBreakpoints.isMobile(context) ? 200 : 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange[400]!, Colors.deepOrange[600]!],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Welcome to Recipe Book',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Discover amazing recipes for every occasion',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _exploreRecipes(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.orange[600],
                ),
                child: const Text('Explore Recipes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // added recentlyviewed
  Widget _buildRecentlyViewed(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recently Viewed',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: SampleData.recentlyViewed.length,
            itemBuilder: (context, index) {
              final recipe = SampleData.recentlyViewed[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 120,
                    color: Colors.orange[50],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: Image.network(
                            recipe.imageUrl,
                            height: 100, // Limit height to prevent overflow
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            recipe.title,
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // added Categories
  Widget _buildQuickCategories(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Categories',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildCategoryChip('Breakfast'),
              _buildCategoryChip('Lunch'),
              _buildCategoryChip('Dinner'),
              _buildCategoryChip('Dessert'),
              _buildCategoryChip('Vegan'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.orange[100],
      ),
    );
  }

  Widget _buildFeaturedRecipes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Recipes',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () => _viewAllRecipes(context),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ResponsiveRecipeGrid(
          recipes: SampleData.featuredRecipes,
          maxItems: ResponsiveBreakpoints.isMobile(context) ? 4 : 6,
        ),
      ],
    );
  }

  // Helper methods
  void _showSearch(BuildContext context) {
    // Implement search functionality
  }

  void _navigateToShoppingList(BuildContext context) {
    // Navigate to shopping list
  }

  void _exploreRecipes(BuildContext context) {
    // Navigate to recipe list
  }

  void _viewAllRecipes(BuildContext context) {
    // Navigate to all recipes
  }
}
