import 'package:flutter/cupertino.dart';

class CartModle {
  final String image;
  final String name;
  final double price;
  final int quantity;
  final String subname;

  CartModle({
    @required this.image,
    @required this.name,
    @required this.price,
    @required this.quantity,
    @required this.subname,
  });
}