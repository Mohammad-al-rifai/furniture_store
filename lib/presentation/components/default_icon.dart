import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultIcon extends StatelessWidget {
  const DefaultIcon({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      fit: BoxFit.cover,
      color: ColorManager.darkPrimary,
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }
}
