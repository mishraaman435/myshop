import 'package:flutter/material.dart';
import 'package:myshop/screens/homepage.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => HomePage(),
              ),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "About",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(bottom: 20, left: 15, right: 15, top: 20),
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.amberAccent,
                width: 6,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Disclaimer : This App has been designed as an Academic project, Images and content used in this app are not necessarily mine and does not necessarily represent the views of any organisation or any other individuals referenced or acknowledged within this App.",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black87,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.justify,
                ),
                heightFactor: 2,
              ),
              Center(
                child: Text(
                  "© 2022 Aman Mishra",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Founder of this application ",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
