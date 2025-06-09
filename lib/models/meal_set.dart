import 'food.dart';

class MealSet {
  final String id;
  final String name;
  final String description;
  final List<Food> foods;
  final double totalPrice;
  final Map<String, double> totalNutrition;
  final int totalCookingTime;

  MealSet({
    required this.id,
    required this.name,
    required this.description,
    required this.foods,
  }) : totalPrice = foods.fold(0, (sum, food) => sum + food.price),
       totalCookingTime = foods.fold(0, (sum, food) => sum + food.cookingTime),
       totalNutrition = _calculateTotalNutrition(foods);

  static Map<String, double> _calculateTotalNutrition(List<Food> foods) {
    final nutrition = <String, double>{};
    for (final food in foods) {
      food.nutrition.forEach((key, value) {
        nutrition[key] = (nutrition[key] ?? 0) + value;
      });
    }
    return nutrition;
  }
} 