import 'package:flutter/material.dart';
import 'package:good_news_flutter/app/data/constants.dart';
import 'package:good_news_flutter/app/models/NewsSource.dart';
import 'package:good_news_flutter/app/models/NewsType.dart';

typedef ValueChangedTwoValues = void Function(
    NewsSource newsSource, NewsType newsType, bool selected);

class NewsSourceItem extends StatelessWidget {
  const NewsSourceItem({
    Key key,
    this.model,
    this.onTypeTap,
  }) : super(key: key);

  final NewsSource model;
  final ValueChangedTwoValues onTypeTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.network(
                    '${Constants.baseUrl}${model.imageUrl}',
                    width: 50,
                    height: 50,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(width: 8),
                  Text(
                    model.name,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SingleChildScrollView(
                padding: EdgeInsets.only(left: 58),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(model.types.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ChoiceChip(
                        selectedColor: Colors.blue[400],
                        labelStyle: TextStyle(color: Colors.white),
                        selected: model.types[index].selected,
                        label: Text("${model.types[index].name}"),
                        onSelected: (selected) => onTypeTap(model, model.types[index], selected),
                      ),
                    );
                  },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
