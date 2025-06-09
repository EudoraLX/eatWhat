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

  void _showRandomFoodDialog(BuildContext context) {
    final randomFood = widget.foodService.getRandomFood(_selectedType);
    if (randomFood != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('今天吃什么？'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                randomFood.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('类型：${randomFood.type}'),
              Text('价格：¥${randomFood.price.toStringAsFixed(2)}'),
              if (randomFood.description != null) ...[
                const SizedBox(height: 4),
                Text(randomFood.description!),
              ],
              const SizedBox(height: 8),
              // 血糖提示
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: randomFood.bloodSugarInfo.contains('⚠️')
                      ? Colors.orange.withOpacity(0.1)
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  randomFood.bloodSugarInfo,
                  style: TextStyle(
                    fontSize: 12,
                    color: randomFood.bloodSugarInfo.contains('⚠️')
                        ? Colors.orange[800]
                        : Colors.green[800],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showRandomFoodDialog(context);
              },
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
                _buildTypeChip('低脂餐'),
                _buildTypeChip('低糖餐'),
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
          _showRandomFoodDialog(context);
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