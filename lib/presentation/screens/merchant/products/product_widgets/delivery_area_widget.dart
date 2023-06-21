import 'package:ecommerce/domain/models/product_models/single_pro_model.dart';
import 'package:ecommerce/presentation/components/default_label.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/components/price_widget.dart';
import 'package:ecommerce/presentation/resources/color_manager.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class DeliveryAreaWidget extends StatelessWidget {
  const DeliveryAreaWidget({
    Key? key,
    required this.areas,
  }) : super(key: key);

  final List<SingleProDeliveryArea>? areas;

  @override
  Widget build(BuildContext context) {
    return Conditional.single(
      context: context,
      conditionBuilder: (context) => areas != null && areas!.isNotEmpty,
      widgetBuilder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DefaultLabel(text: AppStrings.deliveryAreas),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.delivery_dining_rounded,
                      color: ColorManager.primary,
                    ),
                    title: MText(
                      text: areas?[index].location ?? '',
                      color: ColorManager.black,
                      notTR: true,
                    ),
                    trailing: priceWidget(
                      price: areas?[index].deliveryPrice.toString() ?? '',
                      fontSize: AppSize.s12,
                    ),
                  ),
                );
              },
              itemCount: areas?.length,
            ),
          ],
        );
      },
      fallbackBuilder: (context) {
        return Center(
          child: MText(
            text: 'This Product Not Available For Delivery!',
            notTR: true,
          ),
        );
      },
    );
  }
}
