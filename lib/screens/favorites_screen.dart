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

  void _loadFavorites() {
    final favoriteIds = widget.favoriteService.getFavoriteIds();
    _favoriteFoods = widget.foodService
        .getAllFoods()
        .where((food) => favoriteIds.contains(food.id))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的收藏'),
      ),
      body: _favoriteFoods.isEmpty
          ? const Center(
              child: Text(
                '还没有收藏任何菜品哦',
                style: TextStyle(fontSize: 16),
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