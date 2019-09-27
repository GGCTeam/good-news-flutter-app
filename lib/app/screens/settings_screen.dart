import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/blocs/settings_screen_bloc.dart';
import 'package:good_news_flutter/app/common/news_source_list_item.dart';
import 'package:good_news_flutter/app/data/storage_service.dart';
import 'package:good_news_flutter/app/models/NewsSource.dart';
import 'package:good_news_flutter/app/platform_specific/platform_list_items_builder.dart';
import 'package:good_news_flutter/app/platform_specific/platform_page_scaffold.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key, this.bloc}) : super(key: key);

  final SettingsScreenBloc bloc;

  static Widget create(BuildContext context) {
    final storage = Provider.of<StorageService>(context);

    return Provider<SettingsScreenBloc>(
      builder: (context) => SettingsScreenBloc(storage: storage),
      child: Consumer<SettingsScreenBloc>(
        builder: (context, bloc, _) => SettingsScreen(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    widget.bloc.get();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformPageScaffold(
      title: 'Settings',
//      isSliverForIOS: true,
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    return StreamBuilder<List<NewsSource>>(
      stream: widget.bloc.newsSourcesStream,
      builder: (context, snapshot) {
        return PlatformListItemsBuilder(
//          isSliverIOS: true,
          snapshot: snapshot,
          itemBuilder: (builder, newsSource, lastItem) => NewsSourceItem(
            model: newsSource,
            onTypeTap: widget.bloc.newsSourceTypeSelected,
          ),
          onRefreshData: widget.bloc.get,
        );
      },
    );
  }
}
