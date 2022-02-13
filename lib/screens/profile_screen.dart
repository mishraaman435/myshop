import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myshop/model/usermodel.dart';
import 'package:myshop/screens/homepage.dart';
import 'package:myshop/widget/mybutton.dart';
import 'package:myshop/widget/mytextformfield.dart';
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel userModel;
  TextEditingController phoneNumber;
  TextEditingController address;
  TextEditingController userName;
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  bool isMale = false;
  void validation() async {
    if (userName.text.isEmpty && phoneNumber.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("All Fields Are Empty"),
        ),
      );
    } else if (userName.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Name Is Empty "),
        ),
      );
    } else if (userName.text.length < 3) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Name should have at least 3 characters "),
        ),
      );
    } else if (phoneNumber.text.length < 10 || phoneNumber.text.length > 10) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Invalid Mobile Number (must be of 10 digits) "),
        ),
      );
    } else {
      userDetailUpdate();
    }
  }

  File _pickedImage;

  PickedFile _image;
  Future<void> getImage({ImageSource source}) async {
    _image = await ImagePicker().getImage(source: source);
    if (_image != null) {
      setState(() {
        _pickedImage = File(_image.path);
      });
    }
  }

  String userUid;

  Future<String> _uploadImage({File image}) async {
    Reference storageReference =  FirebaseStorage.instance.ref().child("UserImage/$userUid");
    UploadTask uploadTask = storageReference.putFile(image);
    TaskSnapshot snapshot = await uploadTask.snapshot;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  void getUserUid() {
    User myUser = FirebaseAuth.instance.currentUser;
    userUid = myUser.uid;
  }

  bool centerCircle = false;
  var imageMap;
  void userDetailUpdate() async {
    setState(() {
      centerCircle = true;
    });
    _pickedImage != null
        ? imageMap = await _uploadImage(image: _pickedImage)
        : Container();
    FirebaseFirestore.instance.collection("User").doc(userUid).update({
      "UserName": userName.text,
      "UserGender": isMale == true ? "Male" : "Female",
      "UserNumber": phoneNumber.text,
      "UserImage": imageMap,
      "UserAddress": address.text
    });
    setState(() {
      centerCircle = false;
    });
    setState(() {
      edit = false;
    });
  }

  Widget _buildSingleContainer(
      {Color color, String startText, String endText}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 55,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: edit == true ? color : Colors.white,
          borderRadius: edit == false
              ? BorderRadius.circular(30)
              : BorderRadius.circular(0),
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              startText,
              style: TextStyle(fontSize: 17, color: Colors.black45),
            ),
            Text(
              endText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String userImage;
  bool edit = false;
  Widget _buildContainerPart() {
    address = TextEditingController(text: userModel.userAddress);
    userName = TextEditingController(text: userModel.userName);
    phoneNumber = TextEditingController(text: userModel.userPhoneNumber);
    if (userModel.userGender == "Male") {
      isMale = true;
    } else {
      isMale = false;
    }
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSingleContainer(
            endText: userModel.userName,
            startText: "Name",
          ),
          _buildSingleContainer(
            endText: userModel.userEmail,
            startText: "Email",
          ),
          _buildSingleContainer(
            endText: userModel.userGender,
            startText: "Gender",
          ),
          _buildSingleContainer(
            endText: userModel.userPhoneNumber,
            startText: "Mobile Number",
          ),
          _buildSingleContainer(
            endText: userModel.userAddress,
            startText: "Address",
          ),
        ],
      ),
    );
  }

  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("Pick From Camera"),
                    onTap: () {
                      getImage(source: ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text("Pick From Gallery"),
                    onTap: () {
                      getImage(source: ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildTextFormFieldPart(){
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyTextFormField(
            name: "Name",
            controller: userName,
          ),
          _buildSingleContainer(
            color: Colors.grey[300],
            endText: userModel.userEmail,
            startText: "Email",
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isMale = !isMale;
              });
            },
            child: _buildSingleContainer(
              color: Colors.white,
              endText: isMale == true ? "Male" : "Female",
              startText: "Gender",
            ),
          ),
          MyTextFormField(
            name: "Mobile Number",
            controller: phoneNumber,
          ),
          MyTextFormField(
            name: "Address",
            controller: address,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getUserUid();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        leading: edit == true
            ? IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.red,
            size: 30,
          ),
          onPressed: () {
            setState(() {
              edit = false;
            });
          },
        )
            : IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            setState(() {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => HomePage(),
                ),
              );
            });
          },
        ),
        backgroundColor: Colors.white,
        actions: [
          edit == false
              ? Container()
              : IconButton(
            icon: Icon(
              Icons.check,
              size: 30,
              color: Colors.green,
            ),
            onPressed: () {
              validation();
            },
          ),
        ],
      ),
      body: centerCircle == false
          ? ListView(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("User")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var myDoc = snapshot.data.docs;
                myDoc.forEach((checkDocs) {
                  if (checkDocs.data()["UserId"] == userUid) {
                    userModel = UserModel(
                      userEmail: checkDocs.data()["UserEmail"],
                      userImage: checkDocs.data()["UserImage"],
                      userAddress: checkDocs.data()["UserAddress"],
                      userGender: checkDocs.data()["UserGender"],
                      userName: checkDocs.data()["UserName"],
                      userPhoneNumber: checkDocs.data()["UserNumber"],
                    );
                  }
                });
                return Container(
                  height: 660,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                    maxRadius: 65,
                                    backgroundImage: _pickedImage == null
                                        ? userModel.userImage == null
                                        ? AssetImage(
                                        "images/profileimage.jpg")
                                        : NetworkImage(
                                        userModel.userImage)
                                        : FileImage(_pickedImage)),
                              ],
                            ),
                          ),
                          edit == true
                              ? Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context)
                                    .viewPadding
                                    .left +
                                    220,
                                top: MediaQuery.of(context)
                                    .viewPadding
                                    .left +
                                    110),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  myDialogBox(context);
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                  Colors.transparent,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Color(0xff746bc9),
                                  ),
                                ),
                              ),
                            ),
                          )
                              : Container(),
                        ],
                      ),
                      Container(
                        height: 350,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                child: edit == true
                                    ? _buildTextFormFieldPart()
                                    : _buildContainerPart(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: edit == false
                              ? MyButton(
                            name: "Edit Profile",
                            onPressed: () {
                              setState(() {
                                edit = true;
                              });
                            },
                          )
                              : Container(),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ],
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}