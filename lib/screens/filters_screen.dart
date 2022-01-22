import 'package:flutter/material.dart';
import 'package:food_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Map<String, bool> currentFilters;               //we expect the filters map from main dart here
  final Function savefilters;                           //we expect that setfilter method function
  FiltersScreen(this.currentFilters,this.savefilters);  //which is set through this constructor
  //filters function is stored  in a property  of my widget
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}


class _FiltersScreenState extends State<FiltersScreen> {
  bool isGlutenfree = false;   //here we should not initalize with false, we can now use initState to set our own initial state
  bool isVegetarian = false;
  bool isLactosefree = false;
  bool isVegan =  false;
  //It should be bool? _glutenFree = false;
  // Notice the ? after the bool type. It represents that the variable _glutenFree can be null.


  @override
  initState(){
  isGlutenfree = widget.currentFilters['gluten'] == true; //we can override these values based on values we get in our widget currentfilters
  isVegetarian = widget.currentFilters['vegetarian'] == true;
  isVegan = widget.currentFilters['vegan'] == true;
  isLactosefree = widget.currentFilters['lactose'] == true;
  super.initState();
}


Widget buildSwitchListTile(
    String title,
      String description,
      bool currentValue,
      Function updateValue(bool))
        {
        return SwitchListTile(
           title: Text(title),
           value: currentValue,
           subtitle: Text(description),
           onChanged: updateValue,
        );
     }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters"),
        actions: <Widget>[
          IconButton( icon: Icon(Icons.save),
            onPressed:(){
            final selectedFilters = {
              'gluten': isGlutenfree,
              'lactose': isLactosefree,
              'vegan': isVegan,
              'vegetarian' : isVegetarian,
            };
            widget.savefilters(selectedFilters);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text("Adjust Meal Selection",
            style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
              child: ListView(
                children: <Widget>[
                  buildSwitchListTile('Lactose-free', 'only include Gluten free meals', isLactosefree,(newValue) {
                    setState(() {
                      isLactosefree=newValue;
                    });
                    return newValue;
                  }),
                  buildSwitchListTile('Gluten-free', 'only include Gluten free meals', isGlutenfree,(newValue) {
                    setState(() {
                      isGlutenfree=newValue;
                    });
                    return newValue;
                  }),
                  buildSwitchListTile('Vegetarian', 'only include Vegetarian  meals', isVegetarian,(newValue) {
                    setState(() {
                      isVegetarian=newValue;
                    });
                    return newValue;
                  }),
                  buildSwitchListTile('Vegan', 'only include Vegan  meals', isVegan,(newValue) {
                    setState(() {
                      isVegan=newValue;
                    });
                    return newValue;
                  }),
                ],
              ),
          ),
        ],
      )
    );
  }
}
