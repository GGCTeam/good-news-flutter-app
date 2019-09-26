import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/blocs/news_open_bloc.dart';
import 'package:good_news_flutter/app/data/storage_service.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:good_news_flutter/app/models/News.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsOpenScreen extends StatefulWidget {
  const NewsOpenScreen({
    Key key,
    @required this.bloc,
    @required this.model,
  }) : super(key: key);

  final NewsOpenBloc bloc;
  final News model;

  static Widget create(BuildContext context, News news) {
    final storage = Provider.of<StorageService>(context);

    return Provider<NewsOpenBloc>(
      builder: (context) => NewsOpenBloc(storage: storage, news: news),
      child: Consumer<NewsOpenBloc>(
        builder: (context, bloc, _) => NewsOpenScreen(bloc: bloc, model: news),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  //     PageRoute if iOS TODO
  static MaterialPageRoute pageRoute(BuildContext context, News news) {
    return MaterialPageRoute(
      settings: RouteSettings(
        isInitialRoute: false,
      ),
      builder: (context) => NewsOpenScreen.create(context, news),
    );
  }

  @override
  _NewsOpenScreenState createState() => _NewsOpenScreenState();
}

class _NewsOpenScreenState extends State<NewsOpenScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    widget.bloc.checkIfBookmarked(widget.model);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model.newsSource.name),
        elevation: Platform.isIOS ? 0 : 4,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => Share.share(widget.model.link),
          ),
          StreamBuilder(
            stream: widget.bloc.stream,
            builder: (builder, snapshot) {
              if (snapshot.hasData) {
                bool isBookmarked = snapshot.data;

                return IconButton(
                  icon:
                      isBookmarked ? Icon(Icons.star) : Icon(Icons.star_border),
                  onPressed: isBookmarked
                      ? () => widget.bloc.removeFromBookmarks(widget.model)
                      : () => widget.bloc.addToBookmarks(widget.model),
                );
              }

              return IconButton(
                icon: Icon(Icons.star_border),
                onPressed: () {},
              );
            },
          ),
        ],
      ),
      body: _buildContents(),
    );
  }

  Widget _buildContents() {
    return Center(
      // this is done to wait till a page will be presented
      // and then start showing WebView, otherwise it would cause lags
      child: FutureBuilder(
        future: widget.bloc.webViewFuture,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');

              return Builder(builder: (BuildContext context) {
                return WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: widget.model.link,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                );
              });
          }
          return null;
        },
      ),
    );

  }
}
