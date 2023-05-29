import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/presentation/components/button.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/components/text_form_field.dart';
import 'package:ecommerce/presentation/cubit/order_cubit/order_cubit.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MText(
          text: AppStrings.addOrder,
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return BlocConsumer<OrderCubit, OrderStates>(
      listener: (context, state) {
        if (state is AddOrderDoneState) {
          Navigator.of(context).pop();
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
                  const SizedBox(height: AppSize.s8),
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
                  const SizedBox(height: AppSize.s8),
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
                  const SizedBox(height: AppSize.s8),
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
                  const SizedBox(height: AppSize.s8),
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
                  const SizedBox(height: AppSize.s8),
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
                  const SizedBox(height: AppSize.s8),
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
                  const SizedBox(height: AppSize.s8),
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
                  const SizedBox(height: AppSize.s8),
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
                  const SizedBox(height: AppSize.s8),
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
                  const SizedBox(height: AppSize.s8),
                  DefaultButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        OrderCubit.get(context).addOrder(
                          firstName: fNameController.text,
                          lastName: lNameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                          country: countryController.text,
                          city: cityController.text,
                          region: regionController.text,
                          streetNumber: streetNumberController.text,
                          houseNumber: houseNumberController.text,
                          description: descriptionController.text,
                        );
                      }
                    },
                    text: AppStrings.buyNow,
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
