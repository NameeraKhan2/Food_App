import 'package:flutter/material.dart';
import 'package:food_app/dummy_data.dart';
import 'package:food_app/model/meals.dart';

class MealDetails extends StatelessWidget {
  static const routeName= '/meal_details';
  final Function toggle;
    final Function isFavorite;
  MealDetails(this.toggle,this.isFavorite);

  Widget buildSectionTitle(BuildContext context ,String text){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
          text ,
          style: Theme.of(context).textTheme.headline4
      ),
    );
  }
  Widget buildContainer(Widget child){
    return Container(
        decoration: BoxDecoration(
        border: Border.all(color:Colors.grey ),
    borderRadius: BorderRadius.circular(10),
    ),
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    height: 200,
    width: 300,
      child: child,
    );
  }
  @override
  Widget build(BuildContext context) {

    final mealId= ModalRoute.of(context)?.settings.arguments as String;
    final selectedmeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    //String? mealdetailId =routeArgs['id'];
    //final mealdetailssteps=routeArgs['steps'] ;
    //final categoryMeal= DUMMY_MEALS.where((meal) {
    //  return meal.categoryIds.contains(mealdetailssteps);
    // }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedmeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(selectedmeal.imageURL,
              fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
              buildContainer(
                ListView.builder(
                  itemBuilder: (ctx, index) => Card(
                    color:Theme.of(context).accentColor ,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                      child: Text(selectedmeal.ingredients[index],
                      style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.w600),
                      ),
                  ),
              ),
               itemCount: selectedmeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(ListView.builder(
              itemCount: selectedmeal.steps.length,
              itemBuilder: (ctx, index) => Column (children: [ListTile(
                leading: CircleAvatar(
                  child: Text('# ${index + 1}'),
                ),
                title: Text(selectedmeal.steps[index],style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20
                ),
                ),
              ),
                Divider (color: Colors.black,),
              ],
              ),
            ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(mealId) ?  Icons.star :Icons.star_border
        ),
        onPressed: () =>toggle(mealId),
      ),
    );
  }
}

