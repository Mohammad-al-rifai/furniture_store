import 'package:flutter/material.dart';

import '../../../../resources/color_manager.dart';

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
