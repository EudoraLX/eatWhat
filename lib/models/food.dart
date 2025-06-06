class Food {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final List<String> tags;
  final int cookingTime; // 烹饪时间（分钟）
  final Map<String, double> nutrition; // 营养成分

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.tags,
    required this.cookingTime,
    required this.nutrition,
  });
} 