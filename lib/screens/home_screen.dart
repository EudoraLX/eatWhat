import 'package:flutter/material.dart';
import '../widgets/food_card.dart';
import '../widgets/random_button.dart';
import '../widgets/category_selector.dart';
import '../models/food.dart';
import '../services/food_service.dart';
import '../services/favorite_service.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  final FoodService foodService;
  final FavoriteService favoriteService;

  const HomeScreen({
    super.key,
    required this.foodService,
    required this.favoriteService,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedType = '全部';
  List<Food> _foods = [];

  @override
  void initState() {
    super.initState();
    _loadFoods();
  }

  void _loadFoods() {
    _foods = widget.foodService.getFoodsByType(_selectedType);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('吃什么'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(
                    favoriteService: widget.favoriteService,
                    foodService: widget.foodService,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildTypeChip('全部'),
                _buildTypeChip('学生餐'),
                _buildTypeChip('职场餐'),
                _buildTypeChip('家庭餐'),
                _buildTypeChip('快餐'),
                _buildTypeChip('正餐'),
              ],
            ),
          ),
          Expanded(
            child: _foods.isEmpty
                ? const Center(
                    child: Text(
                      '没有找到符合条件的菜品',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _foods.length,
                    itemBuilder: (context, index) {
                      final food = _foods[index];
                      return FoodCard(
                        food: food,
                        favoriteService: widget.favoriteService,
                        onFavoriteChanged: (_) {},
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final randomFood = widget.foodService.getRandomFood(_selectedType);
          if (randomFood != null) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('今天吃什么？'),
                content: Text(randomFood.name),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('再换一个'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('就这个了'),
                  ),
                ],
              ),
            );
          }
        },
        child: const Icon(Icons.shuffle),
      ),
    );
  }

  Widget _buildTypeChip(String type) {
    final isSelected = type == _selectedType;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(type),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedType = selected ? type : '全部';
          });
          _loadFoods();
        },
      ),
    );
  }
} 