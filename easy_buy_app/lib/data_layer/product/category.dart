import 'package:easy_buy_app/apis/products/categories.dart';
import 'package:flutter/material.dart';

class Category {
  final int id;
  final String name;
  final String image;
  final String description;

  Category(
      {required this.id,
      required this.name,
      required this.image,
      required this.description});
}
