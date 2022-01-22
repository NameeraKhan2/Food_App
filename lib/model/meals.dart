import 'package:flutter/foundation.dart';

enum Complexity{
  Simple,
  Challenging,
  Hard
}
enum Affordablility{
Affordable,
  Pricey,
  Luxurious
}

class Meals{

 final String id;
   final List<String> categoryIds;
   final String title;
   final imageURL;
   final List<String> ingredients;
   final List<String> steps;
   final int duration;
   final Complexity complexity ;
   final Affordablility affordablility;
   final  bool isGlutenfree;
   final bool isLactosefree;
   final bool isVegan;
   final bool isVegetarian;

  const Meals({required this.affordablility,
 required this.title,
 required this.id,
 required this.categoryIds,
 required this.complexity,
 required this.duration,
 required this.imageURL,
 required this.ingredients,
 required this.isGlutenfree,
 required this.isLactosefree,
 required this.isVegan,
 required this.isVegetarian,
 required this.steps,
  });
}