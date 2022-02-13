import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myshop/model/usermodel.dart';
import 'package:myshop/provider/MyProvider.dart';
import 'package:myshop/screens/homepage.dart';
import 'package:myshop/widget/mybutton.dart';
import 'package:provider/provider.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController message = TextEditingController();

  String name, email;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void validation() async {
    if (message.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please Fill Message"),
        ),
      );
    } else {
      User user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance.collection("Message").doc(user.uid).set({
        "Name": name,
        "Email": email,
        "Message": message.text,
      });
    }
  }

  Widget _buildSingleField({String name}) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    MyProvider provider;
    provider = Provider.of<MyProvider>(context, listen: false);
    List<UserModel> user = provider.userModelList;
    user.map((e) {
      name = e.userName;
      email = e.userEmail;

      return Container();
    }).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(name);
    return WillPopScope(
      onWillPop: () {
        return Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => HomePage()));
      },
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
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
            "Contact Us",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 27),
            height: 600,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "For contact us",
                  style: TextStyle(
                    color: Color(0xff746bc9),
                    fontSize: 28,
                  ),
                ),
                _buildSingleField(name: name ?? "Name" ),
                _buildSingleField(name: email ?? "Email"),
                Container(
                  height: 200,
                  child: TextFormField(
                    controller: message,
                    expands: true,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Write your Message here....",
                    ),
                  ),
                ),
                MyButton(
                  name: "Submit",
                  onPressed: () {
                    validation();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}