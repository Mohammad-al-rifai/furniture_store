import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/domain/requests/order_requests/add_order_request_model.dart';
import 'package:ecommerce/presentation/components/button.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/components/text_button.dart';
import 'package:ecommerce/presentation/components/text_form_field.dart';
import 'package:ecommerce/presentation/cubit/order_cubit/order_cubit.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../payment/pay_discount_screen.dart';
import '../payment/paypal_payment_screen.dart';

// ignore: must_be_immutable
class AddOrderScreen extends StatelessWidget {
  AddOrderScreen({Key? key}) : super(key: key);

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController streetNumberController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  AddOrderRequest addOrderRequest = AddOrderRequest();
  UserInfo userInfo = UserInfo();
  ShippingAddress shippingAddress = ShippingAddress();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MText(
          text: AppStrings.addOrder,
        ),
        actions: [
          DTextButton(
            text: AppStrings.paymentScreen,
            function: () {},
          ),
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return BlocConsumer<OrderCubit, OrderStates>(
      listener: (context, state) {
        if (state is AddOrderDoneState) {
          navigateTo(context, PayDiscountScreen(orderId: state.orderId));
        }
      },
      builder: (context, state) {
        OrderCubit cubit = OrderCubit.get(context);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TFF(
                    controller: fNameController,
                    label: AppStrings.fName.tr(),
                    prefixIcon: Icons.person,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Your Name Must not be Empty';
                      }
                    },
                  ),
                  SizedBox(height: AppSize.s8),
                  TFF(
                    controller: lNameController,
                    label: AppStrings.lName.tr(),
                    prefixIcon: Icons.person,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Your Name Must not be Empty';
                      }
                    },
                  ),
                  SizedBox(height: AppSize.s8),
                  TFF(
                    controller: phoneController,
                    label: AppStrings.phone.tr(),
                    prefixIcon: Icons.phone,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Your Phone Must not be Empty';
                      }
                    },
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: AppSize.s8),
                  TFF(
                    controller: emailController,
                    label: AppStrings.email.tr(),
                    prefixIcon: Icons.email,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Your email Must not be Empty';
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: AppSize.s8),
                  TFF(
                    controller: countryController,
                    label: AppStrings.country.tr(),
                    prefixIcon: Icons.location_city,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Your Country Must not be Empty';
                      }
                    },
                  ),
                  SizedBox(height: AppSize.s8),
                  TFF(
                    controller: cityController,
                    label: AppStrings.city.tr(),
                    prefixIcon: Icons.location_city_sharp,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Your City Must not be Empty';
                      }
                    },
                  ),
                  SizedBox(height: AppSize.s8),
                  TFF(
                    controller: regionController,
                    label: AppStrings.region.tr(),
                    prefixIcon: Icons.location_history,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Your region Must not be Empty';
                      }
                    },
                  ),
                  SizedBox(height: AppSize.s8),
                  TFF(
                    controller: streetNumberController,
                    label: AppStrings.streetNumber.tr(),
                    prefixIcon: Icons.edit_road,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Your streetNumber Must not be Empty';
                      }
                    },
                  ),
                  SizedBox(height: AppSize.s8),
                  TFF(
                    controller: houseNumberController,
                    label: AppStrings.houseNumber.tr(),
                    prefixIcon: Icons.home_sharp,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Your houseNumber Must not be Empty';
                      }
                    },
                  ),
                  SizedBox(height: AppSize.s8),
                  TFF(
                    controller: descriptionController,
                    label: AppStrings.description.tr(),
                    prefixIcon: Icons.description_outlined,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Your description Must not be Empty';
                      }
                    },
                  ),
                  SizedBox(height: AppSize.s8),
                  DefaultButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        // ========================
                        userInfo.firstName = fNameController.text;
                        userInfo.lastName = lNameController.text;
                        userInfo.phone = phoneController.text;
                        userInfo.email = emailController.text;
                        shippingAddress.country = countryController.text;
                        shippingAddress.city = cityController.text;
                        shippingAddress.region = regionController.text;
                        shippingAddress.streetNumber =
                            streetNumberController.text;
                        shippingAddress.houseNumber =
                            houseNumberController.text;
                        shippingAddress.description =
                            descriptionController.text;

                        addOrderRequest.userInfo = userInfo;
                        addOrderRequest.shippingAddress = shippingAddress;
                        addOrderRequest.paymentMethod = "paypal";

                        // ========================
                        OrderCubit.get(context)
                            .addOrder(addOrderRequest: addOrderRequest);
                      }
                    },
                    text: AppStrings.goNext.tr(),
                    isLoading: state is AddOrderLoadingState,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
