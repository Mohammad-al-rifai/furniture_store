import 'package:ecommerce/domain/models/blockchain/users_point_history.dart';
import 'package:ecommerce/presentation/components/error.dart';
import 'package:ecommerce/presentation/components/loading.dart';
import 'package:ecommerce/presentation/components/my_listview.dart';
import 'package:ecommerce/presentation/components/my_text.dart';
import 'package:ecommerce/presentation/cubit/order_cubit/order_cubit.dart';
import 'package:ecommerce/presentation/resources/string_manager.dart';
import 'package:ecommerce/presentation/screens/order/order_widgets/users_points_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class UserWalletPointsScreen extends StatefulWidget {
  const UserWalletPointsScreen({super.key});

  @override
  State<UserWalletPointsScreen> createState() => _UserWalletPointsScreenState();
}

class _UserWalletPointsScreenState extends State<UserWalletPointsScreen> {
  @override
  void initState() {
    super.initState();
    OrderCubit.get(context).getUsersPointsHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MText(text: AppStrings.pointsHistory4u),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return BlocConsumer<OrderCubit, OrderStates>(
      listener: (context, state) {},
      builder: (context, state) {
        OrderCubit cubit = OrderCubit.get(context);

        if (state is GetUsersPointsLoadingState) {
          return const DefaultLoading();
        }
        if (state is GetUsersPointsErrorState) {
          return const DefaultError();
        }
        if (state is GetUsersPointsDoneState) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                OrderCubit.get(context).usersPointsModel.data != null,
            widgetBuilder: (context) {
              return MyListView<UsersPointsData>(
                physics: const NeverScrollableScrollPhysics(),
                fetchData: () {},
                list: cubit.usersPointsModel.data!,
                noMoreData: true,
                itemBuilder: (context, UsersPointsData data) {
                  return UserPointWidget(data: data);
                },
              );
            },
            fallbackBuilder: (context) {
              return Center(
                child: MText(text: AppStrings.notExistPointsYet),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
