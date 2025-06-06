import 'package:flutter/material.dart';
import '../services/food_service.dart';
import '../models/food.dart';

class RandomButton extends StatelessWidget {
  final Function(Food) onFoodSelected;
  final FoodService _foodService = FoodService();

  RandomButton({
    super.key,
    required this.onFoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          final randomFood = _foodService.getRandomFood();
          onFoodSelected(randomFood);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.shuffle),
            SizedBox(width: 8),
            Text(
              '随机一下',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
} 