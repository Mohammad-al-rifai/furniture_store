import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/domain/models/blockchain/users_point_history.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/styles_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class UserPointWidget extends StatefulWidget {
  final UsersPointsData data;

  const UserPointWidget({Key? key, required this.data}) : super(key: key);

  @override
  _UserPointWidgetState createState() => _UserPointWidgetState();
}

class _UserPointWidgetState extends State<UserPointWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: Alignment.center,
              child: Container(
                width: _isExpanded ? 100 : 50,
                // Adjust width based on expansion state
                child: MText(
                  text: widget.data.points ?? '',
                  color: ColorManager.black,
                ),
              ),
            ),
            SizedBox(width: AppSize.s4),
            MText(
              text: AppStrings.points,
              color: ColorManager.black,
            ),
          ],
        ),
        subtitle: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: Alignment.topLeft,
          child: _isExpanded
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MText(
                      text: widget.data.timestamp.toString(),
                      style: getLightStyle(color: ColorManager.black),
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ),
        trailing: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, -0.5),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: _isExpanded
              ? SizedBox.shrink()
              : MText(text: widget.data.status.toString()),
        ),
      ),
    );
  }
}
