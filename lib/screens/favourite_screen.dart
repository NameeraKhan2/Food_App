import 'package:flutter/material.dart';
import 'package:food_app/model/meals.dart';
import 'package:food_app/widgets/meal_item.dart';

class FavouriteScreen extends StatelessWidget {
  late List<Meals> favoriteMeals;
  FavouriteScreen(this.favoriteMeals);
  @override
  Widget build(BuildContext context) {
    if(favoriteMeals.isEmpty){
      return  Center(child: Text("No favorites yet!! - create one."));
    }else{
      return  ListView.builder(itemBuilder: (ctx, index){
        return MealItem(
          id: favoriteMeals[index].id,
          affordablility: favoriteMeals[index].affordablility,
          title: favoriteMeals[index].title,
          imageURL: favoriteMeals[index].imageURL,
          duration: favoriteMeals[index].duration,
          complexity: favoriteMeals[index].complexity,
        );
      },
        itemCount: favoriteMeals.length ,
      );
    }
  }
}
