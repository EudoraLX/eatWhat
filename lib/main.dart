import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/food_service.dart';
import 'services/favorite_service.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    final foodService = FoodService();
    final favoriteService = FavoriteService(prefs);

    return MaterialApp(
      title: '吃什么',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: HomeScreen(
        foodService: foodService,
        favoriteService: favoriteService,
      ),
    );
  }
} 