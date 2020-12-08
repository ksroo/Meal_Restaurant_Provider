import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/provider/meal_provider.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

import 'categorys_screen.dart';
import 'favorites_screen.dart';

class TabsScreen extends StatefulWidget {




  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

 List<Map<String , Object>> _pages ;
 int _selectPageIndex =0;

 @override
  void initState() {

   Provider.of<MealProvider>(context,listen: false).setData();
   _pages = [
     {
       'page': CategoriesScreen(),
       'title': 'Categories',
     },
     {
       'page': FavoritesScreen(),
       'title': 'Your Favorite',
     }
   ];
    super.initState();
  }



  void _selectPage(int value) {
    setState(() {
      _selectPageIndex = value;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectPageIndex]['title']),
      ),
      body: _pages[_selectPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor:Colors.white ,
        currentIndex: _selectPageIndex ,
        items: [
          BottomNavigationBarItem(
            icon:Icon(Icons.category),
            title:Text('Categories') ,
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.star),
            title:Text('Favorites') ,
          ),

        ],
      ),
      drawer: MainDrawer(),
    );
  }


}
