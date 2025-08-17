import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        dividerColor: Colors.grey[300],
        textTheme: const TextTheme(
          bodySmall: TextStyle(color: Colors.grey),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activeCategory = 'All';
  final List<String> categories = ['All', 'Beach', 'Mountain', 'City', 'Adventure'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Discover',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Amazing places around the world',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Category Filter
                  CategoryFilter(
                    categories: categories,
                    activeCategory: activeCategory,
                    onCategoryChange: (category) {
                      setState(() {
                        activeCategory = category;
                      });
                    },
                  ),
                ],
              ),
            ),
            // Travel Cards Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                  children: [
                    TravelCard(
                      image: 'Assets/Group 5.png',
                      title: 'Beautiful Place',
                      location: 'Amazing Location',
                    ),
                    TravelCard(
                      image: 'Assets/Group 6.png',
                      title: 'Scenic View',
                      location: 'Perfect Destination',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

// BottomNavigation Widget
class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 448), // max-w-md equivalent
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavButton(
                  context,
                  Icons.home,
                  isActive: true,
                  onTap: () {
                    // Handle home tap
                  },
                ),
                _buildNavButton(
                  context,
                  Icons.search,
                  isActive: false,
                  onTap: () {
                    // Handle search tap
                  },
                ),
                _buildNavButton(
                  context,
                  Icons.person,
                  isActive: false,
                  onTap: () {
                    // Handle user tap
                  },
                ),
                _buildNavButton(
                  context,
                  Icons.favorite_border,
                  isActive: false,
                  onTap: () {
                    // Handle heart tap
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context,
    IconData icon, {
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isActive ? Theme.of(context).primaryColor : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20,
                color: isActive
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

// CategoryFilter Widget
class CategoryFilter extends StatelessWidget {
  final List<String> categories;
  final String activeCategory;
  final Function(String) onCategoryChange;

  const CategoryFilter({
    super.key,
    required this.categories,
    required this.activeCategory,
    required this.onCategoryChange,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: categories.map((category) {
          final isActive = activeCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: TextButton(
                onPressed: () => onCategoryChange(category),
                style: TextButton.styleFrom(
                  backgroundColor: isActive
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  foregroundColor: isActive
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).textTheme.bodySmall?.color,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isActive
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// TravelCard Widget
class TravelCard extends StatelessWidget {
  final String image;
  final String title;
  final String location;
  final double? width;
  final double? height;

  const TravelCard({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.grey,
                  ),
                );
              },
            ),
            // Gradient Overlay
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Color.fromRGBO(0, 0, 0, 0.6),
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
            // Text Content
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}