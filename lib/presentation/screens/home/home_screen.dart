import 'package:ecommerce/presentation/components/main_scaffold.dart';
import 'package:ecommerce/presentation/screens/home/widgets/categories_widget.dart';
import 'package:ecommerce/presentation/screens/home/widgets/merchants_widget.dart';
import 'package:flutter/material.dart';
import 'widgets/banners_widget.dart';
import 'widgets/hotselling_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      bodyWidget: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: const [
            // BannerWidget(),
            // CategoriesWidget(),
            // HotSellingWidget(),
            AllMerchantsWidget(),
          ],
        ),
      ),
    );
  }
}
