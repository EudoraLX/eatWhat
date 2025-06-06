import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/food.dart';

class FoodCard extends StatelessWidget {
  final Food food;

  const FoodCard({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 食物图片
          AspectRatio(
            aspectRatio: 16 / 9,
            child: CachedNetworkImage(
              imageUrl: food.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 食物名称
                Text(
                  food.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                // 食物描述
                Text(
                  food.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                // 标签
                Wrap(
                  spacing: 8,
                  children: food.tags.map((tag) {
                    return Chip(
                      label: Text(tag),
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                // 底部信息栏
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 价格
                    Text(
                      '¥ ${food.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    // 烹饪时间
                    Text(
                      '${food.cookingTime}分钟',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    // 操作按钮
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {
                            // TODO: 实现收藏功能
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () {
                            // TODO: 实现分享功能
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 