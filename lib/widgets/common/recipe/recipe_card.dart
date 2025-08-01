// widgets/recipe/recipe_card.dart
import 'package:flutter/material.dart';
import 'package:recipe_book_app/models/recipe.dart';
import 'package:recipe_book_app/utils/route_generator.dart';

class ResponsiveRecipeCard extends StatefulWidget {
  final Recipe recipe;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final bool isFavorite;

  const ResponsiveRecipeCard({
    Key? key,
    required this.recipe,
    this.onTap,
    this.onFavorite,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  State<ResponsiveRecipeCard> createState() => _ResponsiveRecipeCardState();
}

class _ResponsiveRecipeCardState extends State<ResponsiveRecipeCard> {
  void _defaultNavigate(BuildContext context) {
    debugPrint('Navigating to recipe detail...');
    Navigator.pushNamed(
      context,
      RouteGenerator.recipeDetail,
      arguments: widget.recipe,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 400) {
          return _buildWideCard(context);
        } else {
          return _buildCompactCard(context);
        }
      },
    );
  }

  Widget _buildWideCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          debugPrint('Card tapped!');
          _defaultNavigate(context);
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImage(context, height: 200),
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildContent(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          debugPrint('Card tapped!');
          _defaultNavigate(context);
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImage(context, height: 100),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: _buildContent(context, isCompact: true),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context, {required double height}) {
    return Stack(
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            image: DecorationImage(
              image: NetworkImage(widget.recipe.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: _buildFavoriteButton(),
        ),
        Positioned(
          bottom: 8,
          left: 8,
          child: _buildDifficultyBadge(),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, {bool isCompact = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.recipe.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (!isCompact) ...[
          SizedBox(height: 8),
          Text(
            widget.recipe.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildInfoChip(
                icon: Icons.timer,
                label: '${widget.recipe.totalTimeMinutes}min',
                color: Colors.blue,
              ),
              SizedBox(width: 8),
              _buildInfoChip(
                icon: Icons.people,
                label: '${widget.recipe.servings}',
                color: Colors.green,
              ),
              SizedBox(width: 8),
              _buildRating(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFavoriteButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          widget.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: widget.isFavorite ? Colors.red : Colors.grey[600],
        ),
        onPressed: widget.onFavorite,
        constraints: BoxConstraints(minWidth: 40, minHeight: 40),
      ),
    );
  }

  Widget _buildDifficultyBadge() {
    Color badgeColor;
    switch (widget.recipe.difficulty.toLowerCase()) {
      case 'easy':
        badgeColor = Colors.green;
        break;
      case 'medium':
        badgeColor = Colors.orange;
        break;
      case 'hard':
        badgeColor = Colors.red;
        break;
      default:
        badgeColor = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        widget.recipe.difficulty.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: 16),
        SizedBox(width: 4),
        Text(
          widget.recipe.rating.toStringAsFixed(1),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
