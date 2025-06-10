import 'dart:math';
import '../models/food.dart';

class FoodService {
  final List<Food> _foods = [
    Food(
      id: '1',
      name: '红烧肉',
      type: '正餐',
      price: 28.0,
      imageUrl: 'assets/images/braised_pork.png',
      tags: ['家常菜', '肉类', '下饭菜'],
      cookingTime: 45,
      nutrition: {
        '蛋白质': 20.0,
        '脂肪': 25.0,
        '碳水化合物': 15.0,
      },
      category: FoodCategory.regular,
      description: '经典家常菜，肥而不腻',
      cookingSteps: [
        '五花肉切块，焯水去血水',
        '锅中放油，爆香葱姜蒜',
        '放入肉块翻炒至表面金黄',
        '加入生抽、老抽、料酒、冰糖',
        '加入适量清水，大火烧开后转小火慢炖',
        '炖至肉烂，收汁即可'
      ],
    ),
    Food(
      id: '2',
      name: '宫保鸡丁',
      type: '正餐',
      price: 22.0,
      imageUrl: 'assets/images/kungpao_chicken.png',
      tags: ['川菜', '肉类', '下饭菜'],
      cookingTime: 20,
      nutrition: {
        '蛋白质': 18.0,
        '脂肪': 15.0,
        '碳水化合物': 12.0,
      },
      category: FoodCategory.regular,
      description: '麻辣鲜香，下饭神器',
    ),
    Food(
      id: '3',
      name: '兰州拉面',
      type: '快餐',
      price: 15.0,
      imageUrl: 'assets/images/lanzhou_noodles.png',
      tags: ['面食', '快餐', '汤面'],
      cookingTime: 10,
      nutrition: {
        '蛋白质': 12.0,
        '脂肪': 8.0,
        '碳水化合物': 30.0,
      },
      category: FoodCategory.fastFood,
      description: '正宗兰州风味',
    ),
    Food(
      id: '4',
      name: '沙县小吃',
      type: '快餐',
      price: 12.0,
      imageUrl: 'assets/images/shaanxi_food.png',
      tags: ['快餐', '小吃', '经济实惠'],
      cookingTime: 8,
      nutrition: {
        '蛋白质': 10.0,
        '脂肪': 6.0,
        '碳水化合物': 25.0,
      },
      category: FoodCategory.fastFood,
      description: '经济实惠的快餐选择',
    ),
    Food(
      id: '5',
      name: '三明治',
      type: '学生餐',
      price: 8.0,
      imageUrl: 'assets/images/sandwich.png',
      tags: ['西餐', '早餐', '便携'],
      cookingTime: 5,
      nutrition: {
        '蛋白质': 8.0,
        '脂肪': 5.0,
        '碳水化合物': 20.0,
      },
      category: FoodCategory.student,
      description: '营养均衡的早餐选择',
    ),
    Food(
      id: '6',
      name: '便当',
      type: '职场餐',
      price: 18.0,
      imageUrl: 'assets/images/bento.png',
      tags: ['便当', '午餐', '营养均衡'],
      cookingTime: 15,
      nutrition: {
        '蛋白质': 15.0,
        '脂肪': 12.0,
        '碳水化合物': 25.0,
      },
      category: FoodCategory.office,
      description: '营养均衡的午餐选择',
    ),
    Food(
      id: '7',
      name: '家常炒菜',
      type: '家庭餐',
      price: 25.0,
      imageUrl: 'assets/images/home_cooking.png',
      tags: ['家常菜', '炒菜', '下饭菜'],
      cookingTime: 20,
      nutrition: {
        '蛋白质': 12.0,
        '脂肪': 15.0,
        '碳水化合物': 18.0,
      },
      category: FoodCategory.family,
      description: '家的味道',
    ),
    Food(
      id: '8',
      name: '清蒸鱼',
      type: '低脂餐',
      price: 32.0,
      imageUrl: 'assets/images/steamed_fish.png',
      tags: ['海鲜', '低脂', '健康'],
      cookingTime: 25,
      nutrition: {
        '蛋白质': 22.0,
        '脂肪': 5.0,
        '碳水化合物': 2.0,
      },
      category: FoodCategory.lowFat,
      description: '低脂高蛋白的健康选择',
      cookingSteps: [
        '鱼洗净，两面划几刀',
        '放入姜片、葱段',
        '加入适量料酒、盐',
        '蒸锅水开后放入鱼',
        '大火蒸8-10分钟',
        '取出后淋上热油和蒸鱼豉油'
      ],
    ),
    Food(
      id: '9',
      name: '鸡胸肉沙拉',
      type: '低脂餐',
      price: 28.0,
      imageUrl: 'assets/images/chicken_salad.png',
      tags: ['沙拉', '低脂', '健身餐'],
      cookingTime: 15,
      nutrition: {
        '蛋白质': 25.0,
        '脂肪': 3.0,
        '碳水化合物': 8.0,
      },
      category: FoodCategory.lowFat,
      description: '健身人士的最爱',
      cookingSteps: [
        '鸡胸肉切块，用盐和黑胡椒腌制',
        '平底锅煎熟鸡胸肉',
        '准备生菜、番茄、黄瓜等蔬菜',
        '将所有食材放入碗中',
        '加入橄榄油、柠檬汁调味',
        '撒上坚果碎即可'
      ],
    ),
    Food(
      id: '10',
      name: '糙米饭套餐',
      type: '低糖餐',
      price: 26.0,
      imageUrl: 'assets/images/brown_rice.png',
      tags: ['低糖', '粗粮', '健康'],
      cookingTime: 30,
      nutrition: {
        '蛋白质': 15.0,
        '脂肪': 8.0,
        '碳水化合物': 35.0,
      },
      category: FoodCategory.lowSugar,
      description: '低糖健康的选择',
      cookingSteps: [
        '糙米提前浸泡2小时',
        '加入适量水煮饭',
        '准备配菜：清炒时蔬',
        '准备蛋白质：水煮鸡胸肉',
        '准备调味料：低盐酱油',
        '摆盘即可食用'
      ],
    ),
    Food(
      id: '11',
      name: '蔬菜汤',
      type: '低糖餐',
      price: 18.0,
      imageUrl: 'assets/images/vegetable_soup.png',
      tags: ['汤品', '低糖', '素食'],
      cookingTime: 20,
      nutrition: {
        '蛋白质': 5.0,
        '脂肪': 2.0,
        '碳水化合物': 8.0,
      },
      category: FoodCategory.lowSugar,
      description: '清爽健康的汤品',
      cookingSteps: [
        '准备各种蔬菜：胡萝卜、西兰花、玉米等',
        '锅中加入清水烧开',
        '放入蔬菜煮至软烂',
        '加入适量盐调味',
        '最后撒上葱花即可'
      ],
    ),
    Food(
      id: '12',
      name: '营养套餐',
      type: '营养均衡',
      price: 35.0,
      imageUrl: 'assets/images/nutrition_set.png',
      tags: ['套餐', '营养均衡', '健康'],
      cookingTime: 25,
      nutrition: {
        '蛋白质': 20.0,
        '脂肪': 12.0,
        '碳水化合物': 25.0,
      },
      category: FoodCategory.balanced,
      description: '营养均衡的套餐选择',
      cookingSteps: [
        '准备主食：杂粮饭',
        '准备蛋白质：清蒸鱼或鸡胸肉',
        '准备蔬菜：清炒时蔬',
        '准备汤品：蔬菜汤',
        '准备水果：时令水果',
        '合理搭配摆盘'
      ],
    ),
    Food(
      id: '13',
      name: '五谷杂粮饭',
      type: '营养均衡',
      price: 22.0,
      imageUrl: 'assets/images/mixed_grains.png',
      tags: ['杂粮', '营养均衡', '健康'],
      cookingTime: 30,
      nutrition: {
        '蛋白质': 8.0,
        '脂肪': 5.0,
        '碳水化合物': 40.0,
      },
      category: FoodCategory.balanced,
      description: '营养丰富的杂粮饭',
      cookingSteps: [
        '准备各种杂粮：糙米、小米、燕麦等',
        '杂粮提前浸泡2小时',
        '加入适量水煮饭',
        '可以加入一些坚果',
        '煮至软烂即可',
        '可以搭配小菜食用'
      ],
    ),
  ];

  List<Food> getAllFoods() {
    return _foods;
  }

  List<Food> getFoodsByType(String type) {
    if (type == '全部') {
      return _foods;
    }
    return _foods.where((food) => food.type == type).toList();
  }

  Food? getRandomFood([String? type]) {
    final foods = type == null || type == '全部' ? _foods : getFoodsByType(type);
    if (foods.isEmpty) return null;
    return foods[Random().nextInt(foods.length)];
  }
} 