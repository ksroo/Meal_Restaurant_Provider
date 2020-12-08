import 'package:flutter/material.dart';
import 'package:meal_app/provider/meal_provider.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {



  Widget buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilters =
        Provider.of<MealProvider>(context, listen: true).filters;

    return Scaffold(
      appBar: AppBar(
        title: Text("Yor Filters"),

      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection.",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  "Gluten-free",
                  "Only include gluten-free meals.",
                  currentFilters['gluten'],
                  (newValue) {
                    setState(() {
                      currentFilters['gluten'] = newValue;
                    });
                    Provider.of<MealProvider>(context, listen: false).setFilters();
                  },
                ),
                buildSwitchListTile(
                  "Lactose-free",
                  "Only include lactose-free meals.",
                  currentFilters['lactose'],
                  (newValue) {
                    setState(() {
                      currentFilters['lactose'] = newValue;
                    });
                    Provider.of<MealProvider>(context, listen: false).setFilters();
                  },
                ),
                buildSwitchListTile(
                  "Vegetarian",
                  "Only include Vegetarian meals.",
                  currentFilters['vegetarian'],
                  (newValue) {
                    setState(() {
                      currentFilters['vegetarian'] = newValue;
                    });
                    Provider.of<MealProvider>(context, listen: false).setFilters();
                  },
                ),
                buildSwitchListTile(
                  "Vegan",
                  "Only include Vegan meals.",
                  currentFilters['vegan'],
                  (newValue) {
                    setState(() {
                      currentFilters['vegan'] = newValue;
                    });
                    Provider.of<MealProvider>(context, listen: false).setFilters();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
