import 'package:flutter/material.dart';
import '../models/food.dart';

class RandomButton extends StatelessWidget {
  final Function(Food) onFoodSelected;

  const RandomButton({
    super.key,
    required this.onFoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final food = Food(
          id: 'temp',
          name: '随机菜品',
          type: '随机',
          price: 0.0,
          imageUrl: 'https://picsum.photos/800/450?random=0',
          tags: ['随机'],
          cookingTime: 0,
          nutrition: {
            '蛋白质': 0.0,
            '脂肪': 0.0,
            '碳水化合物': 0.0,
          },
          category: FoodCategory.regular,
        );
        onFoodSelected(food);
      },
      child: const Text('随机一下'),
    );
  }
} 