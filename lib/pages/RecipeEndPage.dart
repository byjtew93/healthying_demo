import 'package:flutter/material.dart';
import 'package:healthying/objects/Recipe.dart';
import 'package:healthying/pages/HomePage.dart';
import 'package:healthying/pages/StepPage.dart';

class RecipeEndPageState extends State<StepPage> {
  final Recipe recipe;

  RecipeEndPageState({this.recipe});

  void _toHomePage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Divider(
              height: MediaQuery.of(context).size.height * .1,
            ),
            Text('Bon Appétit !'),
            FlatButton(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              onPressed: _toHomePage,
              child: Text('Accueil'),
            ),
          ],
        ),
      ),
    );
  }
}
