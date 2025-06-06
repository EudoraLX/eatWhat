import 'package:flutter/material.dart';
import '../widgets/food_card.dart';
import '../widgets/random_button.dart';
import '../models/food.dart';
import '../services/food_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FoodService _foodService = FoodService();
  Food? _selectedFood;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('今天吃什么'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // TODO: 导航到收藏页面
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: 导航到设置页面
            },
          ),
        ],
      ),
      body: Column(
        children: [
          RandomButton(
            onFoodSelected: (food) {
              setState(() {
                _selectedFood = food;
              });
            },
          ),
          if (_selectedFood != null) ...[
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: FoodCard(food: _selectedFood!),
              ),
            ),
          ] else ...[
            const Expanded(
              child: Center(
                child: Text(
                  '点击"随机一下"按钮，让我帮你选择今天吃什么！',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
} 