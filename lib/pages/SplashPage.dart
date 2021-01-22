import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthying/pages/HomePage.dart';
import 'package:healthying/services/DBUtils.dart';
import 'package:healthying/services/MemeUtils.dart';
import 'package:healthying/widgets/AppLogo.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    MemeUtils.init(API_KEY: "iQCjK6O1MbLyXBORSCYQox9dUNSEd6NL");
    DBUtils.init().then((value) => Timer(
          Duration(seconds: 1),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage())),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffb1e26c),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .24),
              child: AppLogo(MediaQuery.of(context).size.width * .6),
            ),
            Container(
                child: LinearProgressIndicator(
              minHeight: 20,
              backgroundColor: Colors.black.withOpacity(.7),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            )),
          ],
        ),
      ),
    );
  }
}
