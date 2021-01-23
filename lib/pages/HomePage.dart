import 'package:flutter/material.dart';
import 'package:healthying/pages/searchpage/SearchPage.dart';
import 'package:healthying/services/DBUtils.dart';

import 'RecipePage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showNotch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.only(left: 60, right: 10),
                height: MediaQuery.of(context).size.height * .1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: Text("Recipe Page", style: TextStyle(fontSize: 20))),
                    Icon(Icons.keyboard_arrow_right, size: 50),
                  ],
                ),
                decoration: BoxDecoration(color: Colors.redAccent),
              ),
              onTap: () async => await DBUtils.getRecipe('avocado_toasts')
                  .then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => RecipePage(value)))),
            ),

          ],
        ),
      ),
      /*
      IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchPage())),
              ),
       */
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchPage())),
        child: const Icon(Icons.search),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightGreen,
        shape: _showNotch ? CircularNotchedRectangle() : null,
        child: IconTheme(
          data: IconThemeData(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.menu, size: 30),
                  onPressed: () => print("menu"),
                ),
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_up_sharp, size: 30),
                  onPressed: () => print("keyboard_arrow_up_sharp"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
