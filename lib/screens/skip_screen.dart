import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:myshop/screens/homepage.dart';
import 'package:myshop/widget/mybutton.dart';

class SkipScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: Carousel(
              animationDuration: Duration(seconds: 9),
              autoplay: true,
              boxFit: BoxFit.cover,
              dotBgColor: Colors.transparent,
              dotIncreasedColor: Theme.of(context).primaryColor,
              dotSize: 10,
              images: [
                AssetImage("images/sl2.gif"),
                AssetImage("images/sl.gif"),
                AssetImage("images/sli3.jpeg"),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: MyButton(
                  name: "Skip",
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => HomePage(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}