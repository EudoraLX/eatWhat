import 'package:flutter/material.dart';
import '../models/food.dart';
import '../services/food_service.dart';
import '../services/favorite_service.dart';
import '../widgets/food_card.dart';

class FavoritesScreen extends StatefulWidget {
  final FavoriteService favoriteService;
  final FoodService foodService;

  const FavoritesScreen({
    super.key,
    required this.favoriteService,
    required this.foodService,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Food> _favoriteFoods = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadFavorites();
  }

  void _loadFavorites() {
    final favoriteIds = widget.favoriteService.getFavoriteIds();
    setState(() {
      _favoriteFoods = widget.foodService
          .getAllFoods()
          .where((food) => favoriteIds.contains(food.id))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的收藏'),
      ),
      body: _favoriteFoods.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '还没有收藏任何菜品哦',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '点击菜品上的心形图标来收藏',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _favoriteFoods.length,
              itemBuilder: (context, index) {
                final food = _favoriteFoods[index];
                return FoodCard(
                  food: food,
                  favoriteService: widget.favoriteService,
                  onFavoriteChanged: (isFavorite) {
                    if (!isFavorite) {
                      _loadFavorites();
                    }
                  },
                );
              },
            ),
    );
  }
} 