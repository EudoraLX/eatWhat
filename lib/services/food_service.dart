import 'dart:math';
import '../models/food.dart';

class FoodService {
  static final List<Food> _foods = [
    Food(
      id: '1',
      name: '红烧肉',
      description: '经典家常菜，肥而不腻，入口即化',
      imageUrl: 'https://picsum.photos/800/450?random=1',
      price: 38.0,
      tags: ['家常菜', '肉类', '下饭菜'],
      cookingTime: 45,
      nutrition: {
        '蛋白质': 20.0,
        '脂肪': 25.0,
        '碳水化合物': 5.0,
      },
    ),
    Food(
      id: '2',
      name: '清蒸鲈鱼',
      description: '鲜美可口，营养丰富，适合全家人',
      imageUrl: 'https://picsum.photos/800/450?random=2',
      price: 58.0,
      tags: ['海鲜', '清淡', '营养'],
      cookingTime: 30,
      nutrition: {
        '蛋白质': 18.0,
        '脂肪': 8.0,
        '碳水化合物': 2.0,
      },
    ),
    Food(
      id: '3',
      name: '麻婆豆腐',
      description: '麻辣鲜香，口感细腻，开胃下饭',
      imageUrl: 'https://picsum.photos/800/450?random=3',
      price: 28.0,
      tags: ['川菜', '素食', '下饭菜'],
      cookingTime: 20,
      nutrition: {
        '蛋白质': 12.0,
        '脂肪': 15.0,
        '碳水化合物': 8.0,
      },
    ),
    Food(
      id: '4',
      name: '宫保鸡丁',
      description: '经典川菜，口感麻辣，鸡肉鲜嫩',
      imageUrl: 'https://picsum.photos/800/450?random=4',
      price: 32.0,
      tags: ['川菜', '肉类', '下饭菜'],
      cookingTime: 25,
      nutrition: {
        '蛋白质': 22.0,
        '脂肪': 18.0,
        '碳水化合物': 10.0,
      },
    ),
    Food(
      id: '5',
      name: '番茄炒蛋',
      description: '家常美味，酸甜可口，营养丰富',
      imageUrl: 'https://picsum.photos/800/450?random=5',
      price: 18.0,
      tags: ['家常菜', '素食', '快手菜'],
      cookingTime: 10,
      nutrition: {
        '蛋白质': 8.0,
        '脂肪': 12.0,
        '碳水化合物': 6.0,
      },
    ),
  ];

  // 获取所有菜品
  List<Food> getAllFoods() => _foods;

  // 随机推荐一个菜品
  Food getRandomFood() {
    final random = Random();
    return _foods[random.nextInt(_foods.length)];
  }

  // 根据标签筛选菜品
  List<Food> getFoodsByTag(String tag) {
    return _foods.where((food) => food.tags.contains(tag)).toList();
  }

  // 根据价格范围筛选菜品
  List<Food> getFoodsByPriceRange(double minPrice, double maxPrice) {
    return _foods
        .where((food) => food.price >= minPrice && food.price <= maxPrice)
        .toList();
  }
} 