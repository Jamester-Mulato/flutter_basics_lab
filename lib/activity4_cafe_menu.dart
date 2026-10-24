// Activity 4: Advanced layouts with Stack, ListView and GridView
import 'package:flutter/material.dart';
import 'student.dart';

void main() {
  runApp(const CafeApp());
}

// 1. The data: CafeItem model with enriched details
class CafeItem {
  const CafeItem(
    this.name,
    this.price,
    this.icon, {
    this.category = 'Drinks',
    this.rating = 4.8,
    this.description = 'Freshly prepared with premium local ingredients.',
    this.bestSeller = false,
  });

  final String name;
  final double price;
  final IconData icon;
  final String category;
  final double rating;
  final String description;
  final bool bestSeller;
}

const List<CafeItem> menu = [
  CafeItem(
    'Iced Coffee',
    85,
    Icons.local_cafe_rounded,
    category: 'Drinks',
    rating: 4.9,
    description: 'Cold brewed espresso with milk & caramel drizzle.',
    bestSeller: true,
  ),
  CafeItem(
    'Hot Chocolate',
    75,
    Icons.coffee_rounded,
    category: 'Drinks',
    rating: 4.7,
    description: 'Rich artisanal Davao tablea cocoa with steamed milk.',
  ),
  CafeItem(
    'Fruit Shake',
    90,
    Icons.local_drink_rounded,
    category: 'Drinks',
    rating: 4.8,
    description: 'Fresh seasonal mango and banana blend with crushed ice.',
    bestSeller: true,
  ),
  CafeItem(
    'Cheeseburger',
    120,
    Icons.lunch_dining_rounded,
    category: 'Meals',
    rating: 4.9,
    description: 'Juicy beef patty with melted cheddar, lettuce & special sauce.',
  ),
  CafeItem(
    'Crispy Fries',
    60,
    Icons.fastfood_rounded,
    category: 'Snacks',
    rating: 4.6,
    description: 'Golden seasoned potato fries with garlic aioli dip.',
  ),
  CafeItem(
    'Ensaymada',
    45,
    Icons.bakery_dining_rounded,
    category: 'Desserts',
    rating: 4.8,
    description: 'Traditional buttery brioche topped with grated queso de bola.',
  ),
  CafeItem(
    'Club Sandwich',
    110,
    Icons.breakfast_dining_rounded,
    category: 'Meals',
    rating: 4.7,
    description: 'Triple decker toast with chicken, ham, bacon, and egg.',
    bestSeller: true,
  ),
  CafeItem(
    'Caramel Waffle',
    80,
    Icons.cake_rounded,
    category: 'Desserts',
    rating: 4.9,
    description: 'Warm Belgian waffle drizzled with salted caramel.',
  ),
];

const List<String> categories = ['All', 'Drinks', 'Snacks', 'Meals', 'Desserts'];

class CafeApp extends StatelessWidget {
  const CafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity 4 - Campus Café',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: studentColor,
          brightness: Brightness.light,
        ),
      ),
      home: const MenuPage(),
    );
  }
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final Set<String> _cart = <String>{};
  final Set<String> _favorites = <String>{};

  void _toggleFavorite(String name) {
    setState(() {
      if (_favorites.contains(name)) {
        _favorites.remove(name);
      } else {
        _favorites.add(name);
      }
    });
  }

  void _addToCart(CafeItem item) {
    setState(() {
      _cart.add(item.name);
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added ${item.name} to order!'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _cart.remove(item.name);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    // Filter items based on selected category & search query
    final filteredMenu = menu.where((item) {
      final matchesCategory = _selectedCategory == 'All' || item.category == _selectedCategory;
      final matchesSearch = item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity 4 - Campus Café'),
        centerTitle: true,
        elevation: 2,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                tooltip: 'Cart',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Your order has ${_cart.length} unique item(s).'),
                    ),
                  );
                },
              ),
              if (_cart.isNotEmpty)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '${_cart.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // 2. Banner: a Stack puts widgets on top of each other
          Stack(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.primary, colors.primaryContainer],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Positioned(
                right: -20,
                bottom: -30,
                child: Icon(
                  Icons.local_cafe_rounded,
                  size: 190,
                  color: colors.onPrimary.withAlpha(40),
                ),
              ),
              Positioned(
                left: 20,
                top: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Campus Café & Roastery',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: colors.onPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Freshly brewed daily for students & faculty',
                              style: TextStyle(
                                fontSize: 13,
                                color: colors.onPrimary.withAlpha(220),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green.shade600,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(40),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.access_time_filled_rounded, size: 14, color: Colors.white),
                              SizedBox(width: 4),
                              Text(
                                'OPEN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Quick Search Bar
                    Container(
                      height: 42,
                      decoration: BoxDecoration(
                        color: colors.surface.withAlpha(240),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: colors.shadow.withAlpha(30),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search food or drinks...',
                          hintStyle: TextStyle(fontSize: 13, color: colors.outline),
                          prefixIcon: Icon(Icons.search_rounded, size: 20, color: colors.primary),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // 3. Categories: a horizontal ListView that scrolls sideways
          Container(
            height: 58,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == _selectedCategory;

                return FilterChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  showCheckmark: false,
                  avatar: isSelected
                      ? Icon(Icons.check_rounded, size: 16, color: colors.onPrimary)
                      : null,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  backgroundColor: colors.surfaceContainerLow,
                  selectedColor: colors.primary,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? colors.onPrimary : colors.onSurface,
                  ),
                );
              },
            ),
          ),

          // 4. Menu: a GridView that fills the remaining space
          Expanded(
            child: filteredMenu.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off_rounded, size: 64, color: colors.outline),
                        const SizedBox(height: 12),
                        Text(
                          'No items found',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 220,
                      childAspectRatio: 0.72,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: filteredMenu.length,
                    itemBuilder: (context, index) {
                      final item = filteredMenu[index];
                      return MenuCard(
                        item: item,
                        isFavorite: _favorites.contains(item.name),
                        isInCart: _cart.contains(item.name),
                        onFavoriteToggle: () => _toggleFavorite(item.name),
                        onAddToCart: () => _addToCart(item),
                      );
                    },
                  ),
          ),

          // Bottom Order Status bar if items exist in cart
          if (_cart.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest,
                border: Border(top: BorderSide(color: colors.outlineVariant.withAlpha(80))),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.shopping_bag_rounded, size: 18, color: colors.onPrimary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${_cart.length} item(s) in cart',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Text(
                          'Tap checkout to review',
                          style: TextStyle(fontSize: 11, color: colors.outline),
                        ),
                      ],
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Order placed successfully!')),
                      );
                    },
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// 5. One menu card; a Stack adds the "Best seller" badge & favorite icon on top
class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.item,
    this.isFavorite = false,
    this.isInCart = false,
    this.onFavoriteToggle,
    this.onAddToCart,
  });

  final CafeItem item;
  final bool isFavorite;
  final bool isInCart;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onAddToCart;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isInCart ? colors.primary : colors.outlineVariant.withAlpha(60),
          width: isInCart ? 1.5 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Avatar Circle
                Center(
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: colors.primaryContainer.withAlpha(120),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item.icon, size: 44, color: colors.primary),
                  ),
                ),

                const SizedBox(height: 12),

                // Rating & Category
                Row(
                  children: [
                    const Icon(Icons.star_rounded, size: 16, color: Colors.amber),
                    const SizedBox(width: 3),
                    Text(
                      '${item.rating}',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: colors.secondaryContainer.withAlpha(140),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.category,
                        style: TextStyle(fontSize: 10, color: colors.onSecondaryContainer),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // Name
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 2),

                // Description
                Expanded(
                  child: Text(
                    item.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11, color: colors.outline, height: 1.2),
                  ),
                ),

                const SizedBox(height: 8),

                // Price & Add to Cart Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₱${item.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: colors.primary,
                      ),
                    ),
                    InkWell(
                      onTap: onAddToCart,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: isInCart ? colors.primary : colors.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isInCart ? Icons.check_rounded : Icons.add_rounded,
                          size: 18,
                          color: isInCart ? colors.onPrimary : colors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Best Seller Badge
          if (item.bestSeller)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.deepOrange, Colors.orangeAccent],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withAlpha(80),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.local_fire_department_rounded, size: 12, color: Colors.white),
                    SizedBox(width: 2),
                    Text(
                      'Best seller',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Favorite Heart Toggle
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              iconSize: 20,
              icon: Icon(
                isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                color: isFavorite ? Colors.redAccent : colors.outline,
              ),
              onPressed: onFavoriteToggle,
              tooltip: 'Favorite',
            ),
          ),
        ],
      ),
    );
  }
}