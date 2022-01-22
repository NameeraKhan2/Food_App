import 'package:flutter/material.dart';
import '/model/meals.dart';
import 'package:food_app/screens/categories_screen.dart';
import 'package:food_app/screens/favourite_screen.dart';
import 'package:food_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meals> favoriteMeals;
  TabsScreen(this.favoriteMeals);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
    late List<Map<String, Object>> _pages;
    int selectedPageIndex=0;
 @override
 void initState() {
    _pages =[
      {'page' : CategoriesScreen(),
        'title' : 'Categories'
      },
      {'page' : FavouriteScreen(widget.favoriteMeals),
        'title' : 'Your Favourites'
      },
    ];
    super.initState();
  }

  void selectpage(int index){
 setState(() {
 selectedPageIndex = index;
 });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[selectedPageIndex]['title'].toString(),),
      ),
      drawer: MainDrawer(),
      body: _pages[selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectpage ,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: selectedPageIndex,
        //type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category,),
              title: Text("Categories"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.stars),
            title: Text("Favourites"),
          ),
        ],
      ),
    );
  }
}