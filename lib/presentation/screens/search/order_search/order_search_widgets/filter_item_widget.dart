// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/components/text_button.dart';
import 'package:ecommerce/presentation/components/text_form_field.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/button.dart';
import '../../../../cubit/search_cubit/search_cubit.dart';
import '../../../../resources/color_manager.dart';
import 'filter_data_class.dart';

class FilterItemWidget extends StatefulWidget {
  const FilterItemWidget({
    Key? key,
    required this.filterData,
    required this.cubit,
  }) : super(key: key);

  final FiltersData filterData;
  final SearchCubit cubit;

  @override
  State<FilterItemWidget> createState() => _FilterItemWidgetState();
}

class _FilterItemWidgetState extends State<FilterItemWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      text: widget.filterData.filterName.tr() ?? '',
      isUpperCase: false,
      function: () {
        setState(() {
          if (widget.filterData.isActive) {
            widget.filterData.isActive = false;
            handleRemoveParams(SearchCubit.get(context));
            SearchCubit.get(context).orderAdvancedSearch(
              params: SearchCubit.get(context).orderParams,
            );
          } else {
            widget.filterData.isActive = true;
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: MText(text: widget.filterData.filterName),
                content: TFF(
                  controller: searchController,
                  label: widget.filterData.filterName.tr(),
                  prefixIcon: CupertinoIcons.search,
                  validator: (String value) {},
                ),
                actions: [
                  DTextButton(
                    text: AppStrings.no.tr(),
                    function: () {
                      popScreen(context);
                    },
                  ),
                  BlocProvider.value(
                    value: widget.cubit,
                    child: BlocConsumer<SearchCubit, SearchStates>(
                      listener: (context, state) {
                        if (state is OrderAdvancedSearchDoneState) {
                          searchController.clear();
                          popScreen(context);
                        }
                      },
                      builder: (context, state) {
                        SearchCubit cubit = SearchCubit.get(context);
                        return DTextButton(
                          text: AppStrings.yes.tr(),
                          function: () {
                            handleApplyParams(cubit, searchController.text);
                            SearchCubit.get(context).orderAdvancedSearch(
                              params: cubit.orderParams,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        });
      },
      background: widget.filterData.isActive
          ? ColorManager.primary
          : ColorManager.lightGrey,
    );
  }

  handleApplyParams(SearchCubit cubit, String pText) {
    if (widget.filterData.paramKey == 'firstName') {
      cubit.orderParams?.firstName = pText;
    } else if (widget.filterData.paramKey == 'lastName') {
      cubit.orderParams?.lastName = pText;
    } else if (widget.filterData.paramKey == 'email') {
      cubit.orderParams?.email = pText;
    } else if (widget.filterData.paramKey == 'phone') {
      cubit.orderParams?.phone = pText;
    } else if (widget.filterData.paramKey == 'status') {
      cubit.orderParams?.status = pText;
    } else if (widget.filterData.paramKey == 'totalPrice') {
      cubit.orderParams?.totalPrice = int.parse(pText);
    } else if (widget.filterData.paramKey == 'country') {
      cubit.orderParams?.country = pText;
    } else if (widget.filterData.paramKey == 'city') {
      cubit.orderParams?.city = pText;
    } else if (widget.filterData.paramKey == 'region') {
      cubit.orderParams?.region = pText;
    } else if (widget.filterData.paramKey == 'streetNumber') {
      cubit.orderParams?.streetNumber = int.parse(pText);
    } else if (widget.filterData.paramKey == 'houseNumber') {
      cubit.orderParams?.houseNumber = int.parse(pText);
    } else if (widget.filterData.paramKey == 'paymentMethod') {
      cubit.orderParams?.paymentMethod = pText;
    } else if (widget.filterData.paramKey == 'paymentStatus') {
      cubit.orderParams?.paymentStatus = pText;
    }
  }

  handleRemoveParams(SearchCubit cubit) {
    if (widget.filterData.paramKey == 'firstName') {
      cubit.orderParams?.firstName = null;
    } else if (widget.filterData.paramKey == 'lastName') {
      cubit.orderParams?.lastName = null;
    } else if (widget.filterData.paramKey == 'email') {
      cubit.orderParams?.email = null;
    } else if (widget.filterData.paramKey == 'phone') {
      cubit.orderParams?.phone = null;
    } else if (widget.filterData.paramKey == 'status') {
      cubit.orderParams?.status = null;
    } else if (widget.filterData.paramKey == 'totalPrice') {
      cubit.orderParams?.totalPrice = null;
    } else if (widget.filterData.paramKey == 'country') {
      cubit.orderParams?.country = null;
    } else if (widget.filterData.paramKey == 'city') {
      cubit.orderParams?.city = null;
    } else if (widget.filterData.paramKey == 'region') {
      cubit.orderParams?.region = null;
    } else if (widget.filterData.paramKey == 'streetNumber') {
      cubit.orderParams?.streetNumber = null;
    } else if (widget.filterData.paramKey == 'houseNumber') {
      cubit.orderParams?.houseNumber = null;
    } else if (widget.filterData.paramKey == 'paymentMethod') {
      cubit.orderParams?.paymentMethod = null;
    } else if (widget.filterData.paramKey == 'paymentStatus') {
      cubit.orderParams?.paymentStatus = null;
    }
  }
}
