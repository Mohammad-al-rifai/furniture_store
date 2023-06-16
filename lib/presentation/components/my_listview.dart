import 'package:flutter/material.dart';

import 'loading.dart';

class MyListView<T> extends StatefulWidget {
  const MyListView({
    Key? key,
    required this.fetchData,
    required this.list,
    required this.noMoreData,
    required this.itemBuilder,
  }) : super(key: key);

  final Function fetchData;
  final List<T> list;
  final bool noMoreData;
  final Widget Function(BuildContext context, T item) itemBuilder;

  @override
  State<MyListView<T>> createState() => _MyListViewState<T>();
}

class _MyListViewState<T> extends State<MyListView<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Reached the end of the list
        widget.fetchData();
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
    return ListView(
      shrinkWrap: true,
      controller: _scrollController,
      children: [
        // Items
        ...List<Widget>.from(
          widget.list.map(
            (item) => Builder(
              builder: (context) => widget.itemBuilder(context, item),
            ),
          ),
        ),
        // Add Loading (circular progress indicator at the end),
        // if there are more items to be loaded
        if (widget.noMoreData) ...[
          const SizedBox(),
        ] else ...[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: DefaultLoading(),
          ),
        ]
      ],
    );
  }
}
