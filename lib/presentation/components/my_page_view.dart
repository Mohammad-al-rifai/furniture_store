import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class MyPageView extends StatelessWidget {
  const MyPageView({
    Key? key,
    required this.controller,
    required this.pageWidget,
    required this.itemCount,
    this.height = 200.0,
  }) : super(key: key);

  final PageController controller;
  final Widget Function(BuildContext, int) pageWidget;
  final int itemCount;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          PageView.builder(
            controller: controller,
            onPageChanged: (int index) {},
            physics: const BouncingScrollPhysics(),
            itemBuilder: pageWidget,
            itemCount: itemCount,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              bottom: AppPadding.p18,
              end: AppPadding.p18,
            ),
            child: SmoothPageIndicator(
              controller: controller,
              effect: ExpandingDotsEffect(
                dotColor: ColorManager.lightPrimary.withOpacity(.6),
                activeDotColor: ColorManager.darkPrimary,
                dotHeight: 10.0,
                dotWidth: 10.0,
                spacing: 5,
                expansionFactor: 2,
              ),
              count: itemCount,
            ),
          ),
        ],
      ),
    );
  }
}
