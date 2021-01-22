import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthying/objects/Ingredient.dart';
import 'package:healthying/services/DBUtils.dart';
import 'package:healthying/widgets/DetailGridItem.dart';
import 'package:healthying/widgets/SearchDetailsPage.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Ingredient> _ingredients;

  void _showDetails() {
    List<Ingredient> ingredients = _ingredients.where((e) => e.isSelected).toList(); // TODO
    print(ingredients);
    showModalBottomSheet(context: context, builder: (_) => SearchDetailsPage(details: ingredients), elevation: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade50,
      appBar: AppBar(
        title: Text("Search Page"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: DBUtils.getEveryIngredients().then((value) => _ingredients = value),
          builder: (context, snap) {
            if (snap.hasError)
              return Center(child: Icon(Icons.error, color: Colors.red));
            else if (!snap.hasData) return Center(child: CupertinoActivityIndicator());
            setState(() {});
            return GridView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _ingredients.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => setState(() => _ingredients.elementAt(index).toggleSelect()),
                child: DetailGridItem(ingredient: _ingredients.elementAt(index)),
              ),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.format_list_bulleted),
        onPressed: _ingredients == null ? null : _showDetails,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightGreen,
        shape: CircularNotchedRectangle(),
        child: IconTheme(
          data: IconThemeData(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                IconButton(
                  color: Colors.white.withOpacity(.95),
                  icon: const Icon(Icons.menu, size: 30),
                  onPressed: () => print("menu"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "${_ingredients.fold(0, (p, c) => p + (c.isSelected ? 1 : 0))} items selected",
                    style: TextStyle(color: Colors.white.withOpacity(.95), fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
