import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myshop/model/Category_model.dart';
import 'package:myshop/model/cart_modle.dart';
import 'package:myshop/model/feature_model.dart';
import 'package:myshop/model/skipsc.dart';
import 'package:myshop/model/usermodel.dart';

class MyProvider with ChangeNotifier {
  List<CategoryModel> categoryModelList = [];
  CategoryModel categoryModel;
  Future<void> getCategoryProduct() async {
    List<CategoryModel> list = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('category').get();
    querySnapshot.docs.forEach((Categorydata) {
      categoryModel = CategoryModel(
        image: Categorydata.get("image") ?? "",
        name: Categorydata.get("name"),
      );
      list.add(categoryModel);
    });
    categoryModelList = list;
  }

  List<CategoryModel> get getCategoryModelList {
    return categoryModelList;
  }

//////2///

  List<FeatureModel> featureModelList = [];
  FeatureModel featureModel;
  Future<void> getFeatureProduct() async {
    List<FeatureModel> list = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("feature").get();
    querySnapshot.docs.forEach((Userdata) {
      featureModel = FeatureModel(
        image: Userdata.get("image") ?? "",
        price: Userdata.get("price"),
        title: Userdata.get("title"),
        subtitle: Userdata.get("subtitle"),
        rating: Userdata.get("rating"),
      );
      list.add(featureModel);
    });
    featureModelList = list;
    notifyListeners();
  }

  List<FeatureModel> get getFeatureModelList {
    return featureModelList;
  }

  /////3 Skip
  List<UserModel> userModelList = [];
  UserModel userModel;
  Future<void> getUserData() async {
   List<UserModel> newList = [];
    User currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot userSnapShot =
        await FirebaseFirestore.instance.collection("User").get();
    userSnapShot.docs.forEach(
      (element) {
        if (currentUser.uid == element.get("UserId")) {
          userModel = UserModel(
              userEmail: element.get("UserEmail"),
              userImage: element.get("UserImage"),
              userAddress: element.get("UserAddress"),
              userGender: element.get("UserGender"),
              userName: element.get("UserName"),
              userPhoneNumber: element.get("UserNumber"));
          newList.add(userModel);
        }
       userModelList = newList;
      },
    );
  }

  List<UserModel> get getUserModelList {
    return userModelList;
  }

  /////4
  List<SkipModel> skipModelList = [];
  SkipModel skipModel;
  Future<void> getSkipProduct() async {
    List<SkipModel> list = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("slider").get();
    querySnapshot.docs.forEach((Uerdata) {
      skipModel = SkipModel(
        s1: Uerdata.get("sl1"),
        s2: Uerdata.get("sl2"),
        s3: Uerdata.get("sl3"),
      );
      list.add(skipModel);
    });
    skipModelList = list;
    notifyListeners();
  }

  List<SkipModel> get getSkipModelList {
    return skipModelList;
  }
///////
  List<String> notificationList = [];

  void addNotification(String notification) {
    notificationList.add(notification);
  }

  int get getNotificationIndex {
    return notificationList.length;
  }

  get getNotificationList {
    return notificationList;
  }
  //////4
  List<CartModle> cartList = [];
  List<CartModle> newCartList = [];
  CartModle cartModle;
  void addToCart({
    @required String image,
    @required String name,
    @required double price,
    @required int quantity,
    @required String subname,
  }) {
    cartModle = CartModle(
        image: image,
        name: name,
        price: price,
        quantity: quantity,
        subname: subname);
    newCartList.add(cartModle);
    cartList = newCartList;
  }

  get throwCartList {
    return cartList;
  }

  int totalprice() {
    int total = 0;
    cartList.forEach((element) {
      total += (element.price * element.quantity).toInt();
    });
    return total;
  }

  int deleteIndex;
  void getDeleteIndex(int index) {
    deleteIndex = index;
  }

  void delete() {
    cartList.removeAt(deleteIndex);
    notifyListeners();
  }
}
