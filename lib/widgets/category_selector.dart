import 'package:flutter/material.dart';
import '../models/food.dart';

class CategorySelector extends StatelessWidget {
  final FoodCategory? selectedCategory;
  final Function(FoodCategory) onCategorySelected;

  const CategorySelector({
    super.key,
    this.selectedCategory,
    required this.onCategorySelected,
  });

  String _getCategoryName(FoodCategory category) {
    switch (category) {
      case FoodCategory.student:
        return '学生餐';
      case FoodCategory.office:
        return '职场餐';
      case FoodCategory.family:
        return '家庭餐';
      case FoodCategory.fastFood:
        return '快餐';
      case FoodCategory.regular:
        return '常规餐';
      case FoodCategory.lowFat:
        return '低脂餐';
      case FoodCategory.lowSugar:
        return '低糖餐';
      case FoodCategory.balanced:
        return '营养均衡';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildCategoryChip(null),
          _buildCategoryChip(FoodCategory.student),
          _buildCategoryChip(FoodCategory.office),
          _buildCategoryChip(FoodCategory.family),
          _buildCategoryChip(FoodCategory.fastFood),
          _buildCategoryChip(FoodCategory.regular),
          _buildCategoryChip(FoodCategory.lowFat),
          _buildCategoryChip(FoodCategory.lowSugar),
          _buildCategoryChip(FoodCategory.balanced),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(FoodCategory? category) {
    final isSelected = category == selectedCategory;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(category == null ? '全部' : _getCategoryName(category)),
        selected: isSelected,
        onSelected: (selected) {
          if (selected && category != null) {
            onCategorySelected(category);
          } else if (!selected && category == selectedCategory) {
            onCategorySelected(FoodCategory.regular); // 默认选择常规餐
          }
        },
      ),
    );
  }
} 