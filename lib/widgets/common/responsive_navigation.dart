// widgets/common/responsive_navigation.dart
import 'package:flutter/material.dart';
import 'package:recipe_book_app/screens/favorites_screen.dart';
import 'package:recipe_book_app/screens/home_screen.dart';
import 'package:recipe_book_app/screens/profile_screen.dart';
import 'package:recipe_book_app/utils/responsive_breakpoints.dart';
import 'package:recipe_book_app/screens/recipe_list_screen.dart';
// import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveNavigation extends StatefulWidget {
  const ResponsiveNavigation({super.key});

  @override
  _ResponsiveNavigationState createState() => _ResponsiveNavigationState();
}

class _ResponsiveNavigationState extends State<ResponsiveNavigation> {
  int selectedIndex = 0;

  final List<NavItem> destinations = [
    const NavItem(
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      page: HomeScreen(),
    ),
    const NavItem(
      label: 'Recipes',
      icon: Icons.restaurant_outlined,
      selectedIcon: Icons.restaurant,
      page: RecipeListScreen(),
    ),
    const NavItem(
      label: 'Favorites',
      icon: Icons.favorite_outline,
      selectedIcon: Icons.favorite,
      page: FavoritesScreen(),
    ),
    const NavItem(
      label: 'Profile',
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      page: ProfileScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (ResponsiveBreakpoints.isDesktop(context)) {
      return _buildDesktopLayout();
    } else if (ResponsiveBreakpoints.isTablet(context)) {
      return _buildTabletLayout();
    } else {
      return _buildMobileLayout();
    }
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: true,
            selectedIndex: selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            destinations: destinations.map(_buildRailDestination).toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: destinations[selectedIndex].page),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            destinations: destinations.map(_buildRailDestination).toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: destinations[selectedIndex].page),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      body: destinations[selectedIndex].page,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: destinations.map(_buildBottomDestination).toList(),
      ),
    );
  }

  NavigationRailDestination _buildRailDestination(NavItem dest) {
    return NavigationRailDestination(
      icon: Icon(dest.icon),
      selectedIcon: Icon(dest.selectedIcon),
      label: Text(dest.label),
    );
  }

  NavigationDestination _buildBottomDestination(NavItem dest) {
    return NavigationDestination(
      icon: Icon(dest.icon),
      selectedIcon: Icon(dest.selectedIcon),
      label: dest.label,
    );
  }

  void _onDestinationSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class NavItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Widget page;

  const NavItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.page,
  });
}
