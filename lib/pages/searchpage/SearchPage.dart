import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthying/objects/Ingredient.dart';
import 'package:healthying/services/DBUtils.dart';

import 'package:healthying/widgets/SearchDetailsPage.dart';

import 'SearchPageCategoryInner.dart';

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  _SearchPageState _state;

  void toggleSelected(Ingredient current) {
    _state.toggleSelected(current);
  }

  @override
  State<StatefulWidget> createState() => _state = _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  Set<Ingredient> _ingredients = Set();
  Set<Ingredient> _selected = Set();

  void _showDetails() {
    showModalBottomSheet(context: context, builder: (_) => SearchDetailsPage(details: _selected), elevation: 1);
  }

  toggleSelected(Ingredient current) {
    current.isSelected ? _selected.remove(current) : _selected.add(current);
    current.select();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: FutureBuilder<Set<Ingredient>>(
          future: DBUtils.getEveryIngredients(),
          builder: (_, snap) => Flexible(
            child: ListView.builder(
              itemCount: IngredientCategory.values.length,
              itemBuilder: (context, indexCategory) {
                IngredientCategory current = IngredientCategory.values.elementAt(indexCategory);
                if (snap.hasError)
                  return Center(child: Icon(Icons.error, color: Colors.red));
                else if (!snap.hasData)
                  return Center(child: CupertinoActivityIndicator());
                else
                  return Expanded(
                    child: SearchPageCategoryInner(widget, snap.data.where((e) => e.category == current).toSet(), current),
                  );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.format_list_bulleted),
        onPressed: _ingredients == null ? null : _showDetails,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        color: Colors.lightGreen,
        shape: CircularNotchedRectangle(),
        child: IconTheme(
          data: IconThemeData(color: Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Text("${_selected.length} selected"),
          ),
        ),
      ),
    );
  }
}
