import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/theme/app_theme.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Allows content to go behind the floating nav bar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0), // We use SliverAppBar in HomeScreen
        child: AppBar(elevation: 0, backgroundColor: AppTheme.background),
      ),
      body: navigationShell,
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // --- ✨ NEW ATTRACTIVE BOTTOM NAVIGATION BAR ✨ ---
  Widget _buildBottomNavBar() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      height: 70,
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home,
            label: "Home",
            isSelected: navigationShell.currentIndex == 0,
            onTap: () => _onItemTapped(0),
          ),
          _buildNavItem(
            icon: Icons.category,
            label: "Categories",
            isSelected: navigationShell.currentIndex == 1,
            onTap: () => _onItemTapped(1),
          ),
          _buildNavItem(
            icon: Icons.receipt_long,
            label: "Orders",
            isSelected: navigationShell.currentIndex == 2,
            onTap: () => _onItemTapped(2),
          ),
          _buildNavItem(
            icon: Icons.person,
            label: "Profile",
            isSelected: navigationShell.currentIndex == 3,
            onTap: () => _onItemTapped(3),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  // Helper widget to build each animated navigation item
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryRedLight : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.primaryRed : AppTheme.textLight,
              size: 24,
            ),
            // The label animates its width to appear/disappear smoothly
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              child: Padding(
                padding: EdgeInsets.only(left: isSelected ? 8.0 : 0),
                child: Text(
                  isSelected ? label : "",
                  style: GoogleFonts.outfit(
                    color: AppTheme.primaryRed,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}