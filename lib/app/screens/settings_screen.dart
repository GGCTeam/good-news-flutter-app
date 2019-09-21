import 'dart:io';

import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/blocs/settings_screen_bloc.dart';
import 'package:good_news_flutter/app/common/list_items_builder.dart';
import 'package:good_news_flutter/app/common/news_source_list_item.dart';
import 'package:good_news_flutter/app/data/storage_service.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        elevation: Platform.isIOS ? 0 : 4,
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    return StreamBuilder(
      stream: widget.bloc.newsSourcesStream,
      builder: (builder, snapshot) {
        return ListItemsBuilder(
          snapshot: snapshot,
          itemBuilder: (builder, newsSource) => NewsSourceItem(
            model: newsSource,
            onTypeTap: widget.bloc.newsSourceTypeSelected,
          ),
          onRefreshData: widget.bloc.get,
        );
      },
    );
  }
}
