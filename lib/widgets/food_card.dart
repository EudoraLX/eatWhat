import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/food.dart';
import '../services/favorite_service.dart';

class FoodCard extends StatelessWidget {
  final Food food;
  final FavoriteService favoriteService;
  final Function(bool) onFavoriteChanged;

  const FoodCard({
    super.key,
    required this.food,
    required this.favoriteService,
    required this.onFavoriteChanged,
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        food.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        favoriteService.isFavorite(food.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: favoriteService.isFavorite(food.id)
                            ? Colors.red
                            : Colors.grey,
                      ),
                      onPressed: () async {
                        await favoriteService.toggleFavorite(food.id);
                        onFavoriteChanged(favoriteService.isFavorite(food.id));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '类型：${food.type}',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  '价格：¥${food.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14),
                ),
                if (food.description != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    food.description!,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
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
                    // 烹饪时间
                    Text(
                      '${food.cookingTime}分钟',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    // 操作按钮
                    Row(
                      children: [
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