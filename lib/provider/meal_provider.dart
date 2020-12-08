import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void setFilters() async {
    availableMeals = DUMMY_MEALS.where((meal) {
      if (filters['gluten'] && !meal.isGlutenFree) {
        return false;
      }

      if (filters['lactose'] && !meal.isLactoseFree) {
        return false;
      }

      if (filters['vegan'] && !meal.isVegan) {
        return false;
      }

      if (filters['vegetarian'] && !meal.isVegetarian) {
        return false;
      }

      return true;
    }).toList();
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("gluten", filters['gluten']) ;
    prefs.setBool("lactose", filters['lactose']);
    prefs.setBool("vegan", filters['vegan']);
    prefs.setBool("vegetarian", filters['vegetarian']);
  }

  void setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = prefs.getBool("gluten") ?? false;
    filters['lactose'] = prefs.getBool("lactose")?? false;
    filters['vegan'] = prefs.getBool("vegan")?? false;
    filters['vegetarian'] = prefs.getBool("vegetarian")?? false;


    prefs.getStringList("prefsMealId");
    notifyListeners();
  }

  bool isMealFavorite(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  }




  void toggleFavorite(String mealId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List <String> prefsMealId = [];
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
    } else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      prefsMealId.add(mealId);
    }
    notifyListeners();

    prefs.setStringList("prefsId", prefsMealId);
  }
}
