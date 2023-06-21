import 'package:ecommerce/presentation/components/loading.dart';
import 'package:ecommerce/presentation/components/my_divider.dart';
import 'package:ecommerce/presentation/layouts/merchant_layout/merchant_layout_cubit/merchant_layout_cubit.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:ecommerce/presentation/screens/merchant/products/product_widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class Products4Screen extends StatefulWidget {
  const Products4Screen({
    Key? key,
    required this.catName,
    required this.merchantId,
  }) : super(key: key);

  final String catName;
  final String merchantId;

  @override
  State<Products4Screen> createState() => _Products4ScreenState();
}

class _Products4ScreenState extends State<Products4Screen> {
  @override
  void initState() {
    super.initState();
    MerchantLayoutCubit.get(context).getProductsByCategory(
      catName: widget.catName,
      merchantId: widget.merchantId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.catName),
      ),
      body: BlocConsumer<MerchantLayoutCubit, MerchantLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          MerchantLayoutCubit cubit = MerchantLayoutCubit.get(context);
          print(cubit.productsOfCat.length);
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => cubit.productsOfCat.isNotEmpty,
            widgetBuilder: (context) {
              return Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  vertical: AppPadding.p8,
                ),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ProductWidget(
                      product: cubit.productsOfCat[index],
                    );
                  },
                  itemCount: cubit.productsOfCat.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return MyDivider(
                      margin: 4,
                      color: ColorManager.white,
                    );
                  },
                ),
              );
            },
            fallbackBuilder: (context) => const DefaultLoading(),
          );
        },
      ),
    );
  }
}
