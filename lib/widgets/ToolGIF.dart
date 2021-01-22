import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthying/objects/Tool.dart';
import 'package:healthying/services/MemeUtils.dart';

class ToolGIF extends StatelessWidget {
  final ToolCategory category;

  const ToolGIF({Key key, @required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (this.category) {
      case ToolCategory.SLICE:
        return Image.asset("assets/webp/knife.webp");
      case ToolCategory.OVEN:
        return Image.asset("assets/webp/oven.webp");
      case ToolCategory.STOVE:
        return Image.asset("assets/webp/stove.webp");
      case ToolCategory.MIXER:
        return Image.asset("assets/webp/mixer.webp");
      case ToolCategory.MILL:
        return Image.asset("assets/webp/mill.webp");
      default:
        return FutureBuilder(
          future: MemeUtils.randomGIFByKeyword(keyword: "cooking"),
          builder: (_, snap) {
            if (snap.hasError) {
              print(snap.error);
              return Icon(Icons.error_outlined, color: Colors.red);
            } else if (!snap.hasData) return CupertinoActivityIndicator();
            return snap.data;
          },
        );
    }
  }
}
