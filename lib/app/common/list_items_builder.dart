import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'empty_content.dart';

// TODO
// NOT NEEDED COZ LOGIC MOVED TO ``` PLATFORM_LIST_ITEMS_BUILDER.DART ```

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item, bool lastItem);

class ListItemsBuilder<T> extends StatelessWidget {
  const ListItemsBuilder({
    Key key,
    @required this.snapshot,
    @required this.itemBuilder,
    this.onRefreshData,
  }) : super(key: key);

  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;
  final VoidCallback onRefreshData;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;

      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return SliverToBoxAdapter(child: EmptyContent());
      }
    } else if (snapshot.hasError) {
      return SliverToBoxAdapter(
        child: EmptyContent(
          title: "Something went wrong",
          message: "Can't load items right now",
          showRefreshButton: true,
          onRefreshPressed: onRefreshData ?? () {},
        ),
      );
    }

    return SliverToBoxAdapter(
      child: CupertinoActivityIndicator(
        animating: true,
      ),
    );
//    return Center(
//      child: CircularProgressIndicator(),
//    );
  }

  Widget _buildList(List<T> items) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => itemBuilder(
          context,
          items[index],
          index == items.length - 1,
        ),
        childCount: items.length,
      ),
    );

//    return ListView.separated(
//      itemCount: items.length + 2,
//      separatorBuilder: (context, index) => Divider(height: 0.5),
//      itemBuilder: (context, index) {
//        if (index == 0 || index == items.length + 1) {
//          return Container();
//        }
//
//        return itemBuilder(context, items[index - 1]);
//      },
//    );
  }
}
