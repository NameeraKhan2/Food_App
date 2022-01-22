//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:food_app/model/meals.dart';
import 'package:food_app/widgets/meal_item.dart';


class MealsScreen extends StatefulWidget {
   // late final String categoryId;
 // late final String categoryTitle;
  //MealsScreen(this.categoryId, this.categoryTitle);
static const routeName= '/meals_screen';
late final List<Meals> availablemeals;
MealsScreen(this.availablemeals);

@override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {

  late String categoryTitle;
  late List<Meals> displayedMeals;
  var loadedInitData = false;
  @override
  void initState(){
    super.initState();
  }

@override
  void didChangeDependencies() {
    if(!loadedInitData){
      final routeArgs= ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'].toString();
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availablemeals.where((meal) {
        return meal.categoryIds.contains(categoryId);
      }).toList();
      loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void removeMeal(String mealId){
  setState(() {
    displayedMeals.removeWhere((meals) => meals.id == mealId);
  });
}



  @override
  Widget build(BuildContext context) {

    print("HELLO WORLD "+categoryTitle.toString());
    displayedMeals.forEach((element) {
      print(element.title+"------>>>>>>>");
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(itemBuilder: (ctx, index){
        return MealItem(
          id: displayedMeals[index].id,
          affordablility: displayedMeals[index].affordablility,
          title: displayedMeals[index].title,
          imageURL: displayedMeals[index].imageURL,
          duration: displayedMeals[index].duration,
          complexity: displayedMeals[index].complexity,
        );
        },
       itemCount: displayedMeals.length ,
      ),
    );
  }
}
