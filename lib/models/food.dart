enum FoodCategory {
  student,    // 学生餐
  office,     // 职场餐
  family,     // 家庭餐
  fastFood,   // 快餐
  regular,    // 常规餐
  lowFat,     // 低脂餐
  lowSugar,   // 低糖餐
  balanced    // 营养均衡
}

class Food {
  final String id;
  final String name;
  final String type;
  final double price;
  final String? description;
  final String imageUrl;
  final List<String> tags;
  final int cookingTime; // 烹饪时间（分钟）
  final Map<String, double> nutrition; // 营养成分
  final FoodCategory category; // 分类

  const Food({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.imageUrl,
    required this.tags,
    required this.cookingTime,
    required this.nutrition,
    required this.category,
    this.description,
  });

  // 获取分类的中文名称
  String get categoryName {
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
} 