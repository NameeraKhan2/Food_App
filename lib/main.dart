import 'package:flutter/material.dart';
import 'package:food_app/model/meals.dart';
import 'package:food_app/screens/categories_screen.dart';
import 'package:food_app/screens/filters_screen.dart';
import 'package:food_app/screens/meal_details.dart';
import './screens/meals_screen.dart';
import './screens/meal_details.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';
import './dummy_data.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //storing which filters to set in a map
  //user clicks on a button on filters screen whch updates the filters here in main fart file.
  Map<String, bool> _filters ={
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meals> favMeals =[];
  List<Meals> availMeals= DUMMY_MEALS;   //when the app starts the available meals is just pointer at the meals

  //method that return nothing, expect to get a map,this method should be called
  //from inside filters screen(when a user click button in appbar)
  void setfilters(Map<String, bool> filterdata){
   setState(() {
     _filters = filterdata;

     availMeals = DUMMY_MEALS.where((Meals) {                   //used where to filter the dummy meals and convert it back to list
                                                              //for filtering we pass function to where which receives evry single meal
                                                               //and then has to return true if we want to keep it.
     if(_filters['gluten'] == true && !Meals.isGlutenfree){     //if gluten is true, we need to xclude meals that do have gluten in it.
       return false;
     }
     if(_filters['lactose'] == true && !Meals.isLactosefree){
       return false;
     }
     if(_filters['vegan'] == true && !Meals.isVegan){
       return false;
     }
     if(_filters['vegetarian'] == true && !Meals.isVegetarian){
       return false;
     }
     return true;
     }).toList();
   });
  }
  void toggledFavorite(String mealId){
    final existingindex = favMeals.indexWhere((Meals) => Meals.id == mealId); //pass functn which receives a meal so which runs on every element on the list
    if(existingindex >= 0){                                                   //compare meal's Id to mealId we r getting, if we find meal in favmeals, then we get the index
      setState(() {                                                           //and remove it from the list bcoz it already exists. If meal doesnt exist, existing index will be
        favMeals.removeAt(existingindex);            // -1 and we know thatwe have to add that meal.
      });
    }else{
      setState(() {
        favMeals.add(
          DUMMY_MEALS.firstWhere((Meals) => Meals.id == mealId),
        );
      });
    }
  }
  bool isMealFavorite(String id){
    return favMeals.any((Meals) => Meals.id == id);
  }

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
         primarySwatch: Colors.pink,
      canvasColor: Color.fromRGBO(255,254, 229, 1),
      accentColor: Colors.amberAccent,
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: TextStyle(
            color: Color.fromRGBO(20,51, 51,1),
          ),
          bodyText2: TextStyle(
            color: Color.fromRGBO(20,51, 51,1),
          ),
          subtitle1: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          )
        ),
      ),
     //  home: Categories(),

      initialRoute: '/',
      routes: {
        '/' :(ctx) =>TabsScreen(favMeals),
        MealsScreen.routeName: (ctx) => MealsScreen(availMeals),
        MealDetails.routeName: (ctx) => MealDetails(toggledFavorite,isMealFavorite),
        FiltersScreen.routeName:(ctx) => FiltersScreen(_filters,setfilters), //this is passed to filters screen and avail there
      },
      onGenerateRoute: (settings){
        print (settings.arguments);
        //if( settings.name == '/meal_details'){
         // return MaterialPageRoute(builder: (ctx) => MealsScreen());
        //} else if(
        //settings.name == '/meals_screen'){
          //return MaterialPageRoute(builder: (ctx) => MealDetails());
        //}
        //return MaterialPageRoute(builder: (ctx) => CategoriesScreen()
        //);
      },
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}

