import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/provider/meal_provider.dart';

import 'package:meal_app/widgets/meal_item.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {






  @override
  Widget build(BuildContext context) {
    final List<Meal>  favoriteMeals = Provider.of<MealProvider>(context,listen: true).favoriteMeals;



    if(favoriteMeals.isEmpty){
      return Center(
        child: Text("You have no favorites yet - start adding some!"),
      );
    }
    else{
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            imageUrl: favoriteMeals[index].imageUrl,
            title: favoriteMeals[index].title,
            duration: favoriteMeals[index].duration,
            complexity: favoriteMeals[index].complexity,
            affordability: favoriteMeals[index].affordability,

          );
        },
        itemCount: favoriteMeals.length,
      );
    }

  }
}
