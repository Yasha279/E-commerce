import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

// Your app's specific imports

import 'package:frontend/theme/app_theme.dart';

import 'package:frontend/widgets/product_card.dart';

import '../../controllers/user_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController userController = Get.find<UserController>();

  final List<String> _carouselImages = [
    'assets/images/img1.jpg',
    'assets/images/img2.jpg',
    'assets/images/img3.jpg',
    'assets/images/img4.jpg',
    'assets/images/img5.jpg'
  ];

  final List<Product> _products = [
    Product(
        imagePath: 'assets/images/switch/2M SWITCH.jpg',
        name: 'AURA 8-Switch Panel',
        price: 1250.00),
    Product(
        imagePath: 'assets/images/switch/5PIN SOCKET.jpg',
        name: 'NOVA Dual Switch & Socket',
        price: 480.00),
    Product(
        imagePath: 'assets/images/switch/plate.jpg',
        name: 'STEALTH Power Socket',
        price: 550.00),
    Product(
        imagePath: 'assets/images/switch/rocker.jpg',
        name: 'LINEA Designer Plate',
        price: 220.00),
    Product(
        imagePath: 'assets/images/switch/2M SWITCH.jpg',
        name: 'AURA 8-Switch Panel',
        price: 1250.00),
    Product(
        imagePath: 'assets/images/switch/5PIN SOCKET.jpg',
        name: 'NOVA Dual Switch & Socket',
        price: 480.00),
    Product(
        imagePath: 'assets/images/switch/plate.jpg',
        name: 'STEALTH Power Socket',
        price: 550.00),
    Product(
        imagePath: 'assets/images/switch/rocker.jpg',
        name: 'LINEA Designer Plate',
        price: 220.00),
    Product(
        imagePath: 'assets/images/switch/2M SWITCH.jpg',
        name: 'AURA 8-Switch Panel',
        price: 1250.00),
    Product(
        imagePath: 'assets/images/switch/5PIN SOCKET.jpg',
        name: 'NOVA Dual Switch & Socket',
        price: 480.00),
    Product(
        imagePath: 'assets/images/switch/plate.jpg',
        name: 'STEALTH Power Socket',
        price: 550.00),
    Product(
        imagePath: 'assets/images/switch/rocker.jpg',
        name: 'LINEA Designer Plate',
        price: 220.00),
  ];

  @override
  Widget build(BuildContext context) {
// The Scaffold body is a CustomScrollView to allow for a collapsing AppBar.

// The old _buildAppBar and _buildHomePageContent methods are no longer needed.

    return CustomScrollView(

        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 220.0,
            backgroundColor: AppTheme.primaryRed,
            leadingWidth: 120,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset('assets/images/Golek-light.jpg'),
            ),
            actions: [
              IconButton(
                onPressed: () {/* Navigate to Cart */},
                icon: const Icon(Icons.shopping_cart_outlined,
                    color: Colors.white, size: 26),
              ),
              IconButton(
                onPressed: () {/* Show About Us dialog or page */},
                icon: const Icon(Icons.info_outline,
                    color: Colors.white, size: 26),
              ),
              const SizedBox(width: 8),
            ],

            flexibleSpace: FlexibleSpaceBar(
// The background for the large, expanded AppBar state

              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/golek.jpg', // Use your switchboard image

                    fit: BoxFit.cover,
                  ),

// The Welcome Text, positioned on top of the blurred image

                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Text(
                            'Welcome, ${userController.username.value} 👋',

                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  shadows: [const Shadow(blurRadius: 10.0)],
                                ),
                              )),
                          SizedBox(height: 4),
                          Text(
                            'Find the best quality electricals for your home.',
                            style: GoogleFonts.outfit(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPersistentHeader(
            delegate: SearchBarDelegate(),
            pinned: true,
          ),

          SliverToBoxAdapter(child: _buildImageCarousel(_carouselImages)),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Text(
                'Featured Products',
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
            ),
          ),

          _buildProductGridSliver(),
        ],
    );
  }

  Widget _buildImageCarousel(List<String> images) {
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (context, index, realIndex) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.asset(images[index], fit: BoxFit.cover, width: 1000),
        ),
      ),
      options: CarouselOptions(height: 200, autoPlay: true, enlargeCenterPage: true, viewportFraction: 0.85),
    );
  }

  Widget _buildProductGridSliver() {
// The GridView is now returned as a Sliver so it can be in a CustomScrollView.

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 0.75,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ProductCard(product: _products[index]);
          },
          childCount: _products.length,
        ),
      ),
    );
  }
}

class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppTheme.background,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search for switches, sockets...',
            hintStyle: const TextStyle(color: AppTheme.textLight),
            prefixIcon: const Icon(Icons.search, color: AppTheme.textLight),
            filled: true,
            fillColor: AppTheme.surface,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 88.0;

  @override
  double get minExtent => 88.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
