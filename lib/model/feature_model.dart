import 'package:flutter/material.dart';

class FeatureModel {
  final String image, title, subtitle;
  final double price, rating;

  FeatureModel({
    @required this.image,
    @required this.price,
    @required this.title,
    @required this.subtitle,
    @required this.rating,

  });
}
