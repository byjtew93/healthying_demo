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
  final List<IngredientCategory> tabs = IngredientCategory.values;
  Set<Ingredient> _ingredients = Set();
  Set<Ingredient> _selected = Set();

  void _showDetails() {
    showModalBottomSheet(context: context, builder: (_) => SearchDetailsPage(details: _selected), elevation: 1);
  }

  toggleSelected(Ingredient current) {
    current.isSelected ? _selected.remove(current) : _selected.add(current);
    current.toggleSelect();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent.shade50,
        appBar: AppBar(
          backgroundColor: Color(0xFF191919),
          title: Text("Search Page"),
          bottom: TabBar(
            indicatorColor: Colors.white,
            isScrollable: true,
            tabs: [for (final tab in tabs) Tab(icon: tab.toIcon())],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              for (final tab in tabs)
                FutureBuilder(
                  future: DBUtils.getEveryIngredients(category: tab).then((value) {
                    _ingredients.addAll(value);
                    return value;
                  }),
                  builder: (context, snap) {
                    if (snap.hasError)
                      return Center(child: Icon(Icons.error, color: Colors.red));
                    else
                      return Container(
                        color: tab.toColor(),
                        child: (!snap.hasData)
                            ? Center(child: CupertinoActivityIndicator())
                            : GridView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: snap.data.length,
                                itemBuilder: (context, index) => GestureDetector(
                                  onTap: () => this.toggleSelected(snap.data.elementAt(index)),
                                  child: DetailGridItem(ingredient: snap.data.elementAt(index)),
                                ),
                                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 250,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 0,
                                ),
                              ),
                      );
                  },
                ),
            ],
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
                      "${_selected.length} items selected",
                      style: TextStyle(color: Colors.white.withOpacity(.95), fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
