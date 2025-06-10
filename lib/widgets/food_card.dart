import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import '../models/food.dart';
import '../services/favorite_service.dart';

class FoodCard extends StatefulWidget {
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
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.favoriteService.isFavorite(widget.food.id);
  }

  void _showCookingSteps() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${widget.food.name}的做法'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.food.cookingSteps.isEmpty)
                const Text('暂无烹饪步骤')
              else
                ...widget.food.cookingSteps.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${entry.key + 1}. ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(entry.value)),
                      ],
                    ),
                  );
                }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  void _shareFoodInfo() {
    final foodInfo = '''
${widget.food.name}
类型：${widget.food.type}
价格：¥${widget.food.price.toStringAsFixed(2)}
${widget.food.description != null ? '描述：${widget.food.description}\n' : ''}
烹饪时间：${widget.food.cookingTime}分钟
标签：${widget.food.tags.join('、')}
${widget.food.bloodSugarInfo}

制作方法：
${widget.food.cookingSteps.isEmpty ? '暂无制作方法' : widget.food.cookingSteps.asMap().entries.map((entry) => '${entry.key + 1}. ${entry.value}').join('\n')}
''';

    Clipboard.setData(ClipboardData(text: foodInfo));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('菜品信息已复制到剪贴板')),
    );
  }

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
              imageUrl: widget.food.imageUrl,
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
                        widget.food.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          key: ValueKey<bool>(_isFavorite),
                          color: _isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                      onPressed: () async {
                        await widget.favoriteService.toggleFavorite(widget.food.id);
                        setState(() {
                          _isFavorite = widget.favoriteService.isFavorite(widget.food.id);
                        });
                        widget.onFavoriteChanged(_isFavorite);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '类型：${widget.food.type}',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  '价格：¥${widget.food.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14),
                ),
                if (widget.food.description != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    widget.food.description!,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
                const SizedBox(height: 8),
                // 血糖提示
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.food.bloodSugarInfo.contains('⚠️')
                        ? Colors.orange.withOpacity(0.1)
                        : Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.food.bloodSugarInfo,
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.food.bloodSugarInfo.contains('⚠️')
                          ? Colors.orange[800]
                          : Colors.green[800],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // 标签
                Wrap(
                  spacing: 8,
                  children: widget.food.tags.map((tag) {
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
                      '${widget.food.cookingTime}分钟',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    // 操作按钮
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.menu_book),
                          tooltip: '查看做法',
                          onPressed: _showCookingSteps,
                        ),
                        IconButton(
                          icon: const Icon(Icons.share),
                          tooltip: '分享',
                          onPressed: _shareFoodInfo,
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