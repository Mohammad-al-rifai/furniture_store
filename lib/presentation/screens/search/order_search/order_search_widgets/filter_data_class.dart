import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';


class FiltersData {
  String filterName;
  String paramKey;
  Color backgroundColor;
  bool isActive;

  FiltersData({
    required this.filterName,
    required this.paramKey,
    this.backgroundColor = ColorManager.lightGrey,
    this.isActive = false,
  });
}
