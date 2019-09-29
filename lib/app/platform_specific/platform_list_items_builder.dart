import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:good_news_flutter/app/common/empty_content.dart';
import 'package:good_news_flutter/app/platform_specific/platform_refreshing_indicator.dart';
import 'package:good_news_flutter/app/platform_specific/platform_widget.dart';

typedef ItemWidgetBuilder<T> = Widget Function(
    BuildContext context, T item, bool lastItem);

class PlatformListItemsBuilder<T> extends PlatformWidget {
  PlatformListItemsBuilder({
    @required this.snapshot,
    @required this.itemBuilder,
    this.isSliverIOS = false,
    this.onRefreshData,
  }) {
    noDataEmptyContent = EmptyContent();
    hasErrorEmptyContent = EmptyContent(
      title: "Something went wrong",
      message: "Can't load items right now",
      showRefreshButton: true,
      onRefreshPressed: onRefreshData ?? () {},
    );
  }

  final bool isSliverIOS;
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;
  final VoidCallback onRefreshData;

  Widget noDataEmptyContent;
  Widget hasErrorEmptyContent;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;

      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        if (isSliverIOS) return SliverToBoxAdapter(child: noDataEmptyContent);

        return noDataEmptyContent;
      }
    } else if (snapshot.hasError) {
      if (isSliverIOS) return SliverToBoxAdapter(child: hasErrorEmptyContent);

      return hasErrorEmptyContent;
    }

    if (isSliverIOS)
      return SliverToBoxAdapter(child: Center(child: PlatformRefreshingIndicator()));

    return Center(child: PlatformRefreshingIndicator());
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;

      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return noDataEmptyContent;
      }
    } else if (snapshot.hasError) {
      return hasErrorEmptyContent;
    }

    return Center(child: PlatformRefreshingIndicator());
  }

  Widget _buildList(List<T> items) {
    if (isSliverIOS) {
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
    }

    return ListView.builder(
      itemBuilder: (context, index) => itemBuilder(
        context,
        items[index],
        index == items.length - 1,
      ),
      itemCount: items.length,
    );
  }
}
