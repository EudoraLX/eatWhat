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
  final String? bloodSugarNote; // 血糖提示
  final List<String> cookingSteps; // 烹饪步骤

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
    this.bloodSugarNote,
    this.cookingSteps = const [], // 默认为空列表
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

  // 获取血糖提示
  String get bloodSugarInfo {
    if (bloodSugarNote != null) {
      return bloodSugarNote!;
    }
    
    // 根据营养成分计算血糖影响
    final carbs = nutrition['碳水化合物'] ?? 0;
    final sugar = nutrition['糖分'] ?? 0;
    
    if (carbs > 30 || sugar > 15) {
      return '⚠️ 高糖食物，建议适量食用';
    } else if (carbs > 20 || sugar > 10) {
      return '⚠️ 中等糖分，注意控制食用量';
    } else if (carbs > 10 || sugar > 5) {
      return '✅ 低糖食物，可以适量食用';
    } else {
      return '✅ 极低糖食物，适合控糖人群';
    }
  }
} 