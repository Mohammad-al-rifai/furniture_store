import 'package:ecommerce/presentation/components/my_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/functions.dart';
import '../../../domain/models/featuers_models/featuers_model.dart';
import '../../components/default_image.dart';
import '../../components/my_text.dart';
import '../../layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class FeaturesPagination extends StatefulWidget {
  const FeaturesPagination({super.key});

  @override
  State<FeaturesPagination> createState() => _FeaturesPaginationState();
}

class _FeaturesPaginationState extends State<FeaturesPagination> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Reached the end of the list
        context.read<HomeLayoutCubit>().getFeatures();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
          return MyListView<FeatureData>(
            fetchData: () => cubit.getFeatures(),
            list: cubit.featureList,
            noMoreData: cubit.noMoreFeatures,
            itemBuilder: (context, FeatureData data) => buildFeatureItem(data),
          );
          // Column(
          //   children: [
          //     const DefaultLabel(text: AppStrings.siteFeatures),
          //     SizedBox(height: AppSize.s8),
          //     Expanded(
          //       child: ListView(
          //         shrinkWrap: true,
          //         controller: _scrollController,
          //         children: [
          //           // Items
          //           ...List<Widget>.from(
          //             cubit.featureList.map(
          //               (e) => Builder(
          //                 builder: (context) => buildFeatureItem(e),
          //               ),
          //             ),
          //           ),
          //           // add Loading (circular progress indicator at the end),
          //           // if there are more items to be loaded
          //           if (cubit.noMoreFeatures) ...[
          //             const SizedBox(),
          //           ] else ...[
          //             const Padding(
          //               padding: EdgeInsets.symmetric(vertical: 25),
          //               child: DefaultLoading(),
          //             ),
          //           ]
          //         ],
          //       ),
          //     ),
          //   ],
          // );
        },
      ),
    );
  }

  Widget buildFeatureItem(FeatureData? data) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: AppSize.s200,
          margin: EdgeInsetsDirectional.all(AppSize.s8),
          decoration: getDeco(),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: DefaultImage(
            imageUrl: data?.icon,
            clickable: true,
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsetsDirectional.all(AppMargin.m8),
          padding: const EdgeInsetsDirectional.all(AppPadding.p4),
          decoration: getDeco(
            color: ColorManager.warning.withOpacity(.4),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MText(
                text: data?.title ?? '',
                style: getMediumStyle(
                  color: Colors.white,
                  fontSize: AppSize.s18,
                ),
              ),
              MText(
                text: data?.description ?? '',
                style: getMediumStyle(
                  color: Colors.white,
                ),
                maxLines: 2,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
