import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double _width;

  AppLogo(this._width);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: _width,
        ),
        Text(
          "Healthying",
          style: TextStyle(fontSize: 34, color: Colors.blueGrey),
        ),
        Text(
          "Prettify your casual food !",
          style: TextStyle(fontSize: 26, color: Colors.white.withOpacity(.7), fontStyle: FontStyle.italic),
        )
      ],
    );
  }
}
