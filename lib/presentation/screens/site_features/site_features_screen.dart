import 'package:ecommerce/domain/models/featuers_models/featuers_model.dart';
import 'package:ecommerce/presentation/components/my_listview.dart';
import 'package:ecommerce/presentation/layouts/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:ecommerce/presentation/screens/site_features/widgets/site_features_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SiteFeaturesScreen extends StatelessWidget {
  const SiteFeaturesScreen({super.key});

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
            itemBuilder: (context, FeatureData data) => SiteFeaturesWidget(
              data: data,
            ),
          );
        },
      ),
    );
  }
}
