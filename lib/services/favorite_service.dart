import 'package:shared_preferences/shared_preferences.dart';
import '../models/food.dart';

class FavoriteService {
  static const String _favoritesKey = 'favorites';
  final SharedPreferences _prefs;

  FavoriteService(this._prefs);

  // 获取所有收藏的菜品ID
  List<String> getFavoriteIds() {
    return _prefs.getStringList(_favoritesKey) ?? [];
  }

  // 检查菜品是否已收藏
  bool isFavorite(String foodId) {
    return getFavoriteIds().contains(foodId);
  }

  // 切换收藏状态
  Future<void> toggleFavorite(String foodId) async {
    final favorites = getFavoriteIds();
    if (favorites.contains(foodId)) {
      favorites.remove(foodId);
    } else {
      favorites.add(foodId);
    }
    await _prefs.setStringList(_favoritesKey, favorites);
  }
} 