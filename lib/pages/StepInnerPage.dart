import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthying/objects/RecipeStep.dart';
import 'package:healthying/objects/Tool.dart';
import 'package:healthying/widgets/ToolGIF.dart';

class StepInnerPage extends StatefulWidget {
  final RecipeStep step;

  const StepInnerPage({Key key, @required this.step}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StepInnerPageState();
}

class _StepInnerPageState extends State<StepInnerPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // IMPORTANT !
    Size size = MediaQuery.of(context).size;
    return Container(
      color: widget.step.toolCategory.color,
      padding: EdgeInsets.symmetric(horizontal: size.width * .05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            if (widget.step.optional)
              Container(
                margin: EdgeInsets.only(top: size.height * .035, bottom: size.height * .08),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 26),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent, width: 0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.yellowAccent.withOpacity(.85),
                  boxShadow: [BoxShadow(offset: Offset(2, -2))],
                ),
                child: Text("Optionel !"),
              ),
            Container(
              height: size.height * .25,
              margin: EdgeInsets.only(top: size.height * .035, bottom: size.height * .08),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 26),
              child: ToolGIF(category: widget.step.toolCategory),
            ),
            Text(
              widget.step.instruction,
              style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
            ),
          ]),
          if (widget.step.breakpoint != null && widget.step.breakpoint.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: Colors.redAccent,
                boxShadow: [BoxShadow(color: Colors.yellow, offset: Offset(0, -2), blurRadius: 3, spreadRadius: 2)],
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              margin: EdgeInsets.only(top: size.height * .035, bottom: size.height * .03),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 26),
              child: Text(
                widget.step.breakpointText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
            ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
