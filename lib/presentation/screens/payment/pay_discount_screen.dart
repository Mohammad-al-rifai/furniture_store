import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/presentation/components/button.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/screens/payment/paypal_payment_screen.dart';
import 'package:flutter/material.dart';

class PayDiscountScreen extends StatefulWidget {
  const PayDiscountScreen({
    super.key,
    required this.orderId,
  });

  final String? orderId;

  @override
  State<PayDiscountScreen> createState() => _PayDiscountScreenState();
}

class _PayDiscountScreenState extends State<PayDiscountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MText(
          text: AppStrings.checkPayDiscountScreen,
        ),
      ),
      body: Column(
        children: [
          DefaultButton(
            function: () {
              navigateTo(
                context,
                PayPalPaymentScreen(orderId: widget.orderId),
              );
            },
            text: AppStrings.pay,
          ),
        ],
      ),
    );
  }
}
