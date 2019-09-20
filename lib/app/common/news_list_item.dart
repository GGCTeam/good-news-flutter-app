import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:good_news_flutter/app/data/constants.dart';
import 'package:good_news_flutter/app/models/News.dart';

class NewsListItem extends StatelessWidget {
  const NewsListItem({
    Key key,
    @required this.model,
    @required this.onTap,
    @required this.onBookmarkTap,
  }) : super(key: key);

  final News model;
  final ValueChanged<News> onTap;
  final ValueChanged<News> onBookmarkTap;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          color: Colors.amber,
          icon: Icons.star_border,
          onTap: () => onBookmarkTap(model),
        ),
      ],
      child: InkWell(
        onTap: () => onTap(model),
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildNewsSourceImageAndNewsType(),
              _buildContents(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsSourceImageAndNewsType() {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            '${Constants.baseUrl}${model.newsSource.imageUrl}',
            width: 40,
            height: 40,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(height: 4),
          Text(
            model.newsType.name,
            style: TextStyle(fontSize: 8, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildContents() {
    final date =
        new DateTime.fromMillisecondsSinceEpoch(model.timeAdded * 1000);
    final formattedDate =
        formatDate(date, [HH, ':', nn, ', ', dd, '.', mm, '.', yyyy]);

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 8, right: 4, top: 4, bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              model.title,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            if (model.preamble != '') ...<Widget>[
              Text(
                model.preamble,
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 8),
            ],
            Text(
              formattedDate,
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
