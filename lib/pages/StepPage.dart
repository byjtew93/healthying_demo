import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthying/objects/Recipe.dart';
import 'package:healthying/pages/HomePage.dart';
import 'package:healthying/pages/StepInnerPage.dart';

class StepPage extends StatefulWidget {
  final Recipe recipe;

  const StepPage({this.recipe});

  @override
  State<StatefulWidget> createState() => _StepPageState();
}

class _StepPageState extends State<StepPage> with SingleTickerProviderStateMixin {
  PageController _pageController;
  int _currentPageIndex = 0;
  Animation<double> _progressAnimation;
  AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _progressController = AnimationController(duration: const Duration(seconds: 10), vsync: this);
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_progressController)
      ..addListener(() {
        setState(() {});
      });
  }

  void _previousPage() {
    if (_currentPageIndex == 0)
      Navigator.pop(context);
    else
      _pageController.previousPage(duration: Duration(milliseconds: 350), curve: Curves.decelerate);
  }

  void _nextPage() {
    if (_currentPageIndex == widget.recipe.steps.length)
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
    else
      _pageController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.easeInCirc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemBuilder: (ctx, index) => index == widget.recipe.steps.length
                    ? widget.recipe.endView(MediaQuery.of(ctx).size)
                    : StepInnerPage(step: widget.recipe.steps.elementAt(index)),
                itemCount: widget.recipe.steps.length + 1,
                onPageChanged: (index) {
                  print("onPageChanged: ($index) ");
                  _currentPageIndex = index;
                  print("animateTo(${(index / widget.recipe.steps.length)})");
                  _progressController.animateTo(
                    index / widget.recipe.steps.length,
                    duration: Duration(milliseconds: 150),
                    curve: Curves.decelerate,
                  );
                },
              ),
            ),
            LinearProgressIndicator(
              value: _progressAnimation.value,
              minHeight: MediaQuery.of(context).size.height * .02,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 40,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(
                padding: const EdgeInsets.symmetric(vertical: 10),
                onPressed: _previousPage,
                child: Icon(Icons.keyboard_arrow_left_sharp),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.red)),
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(vertical: 10),
                onPressed: _nextPage,
                child: Icon(Icons.keyboard_arrow_right_sharp),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.red)),
              ),
            ],
          ),
        ),
        color: Colors.white38.withOpacity(.9),
      ),
    );
  }
}
