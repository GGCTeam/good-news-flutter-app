import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:good_news_flutter/app/platform_specific/platform_widget.dart';

class ShareIconSlideAction extends PlatformWidget {
  ShareIconSlideAction({
    this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return IconSlideAction(
      color: Colors.blue,
      icon: CupertinoIcons.share,
      onTap: onTap,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return IconSlideAction(
      color: Colors.blue,
      icon: Icons.share,
      onTap: onTap,
    );
  }
}

class BookmarkIconSlideAction extends PlatformWidget {
  BookmarkIconSlideAction({
    this.isBookmarked,
    this.onTap,
  });

  final bool isBookmarked;
  final VoidCallback onTap;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return IconSlideAction(
      color: isBookmarked ? Colors.red : Colors.amber,
      foregroundColor: isBookmarked ? Colors.white : Colors.black,
      icon: isBookmarked ? CupertinoIcons.bookmark_solid : CupertinoIcons.bookmark,
      onTap: onTap,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return IconSlideAction(
      color: isBookmarked ? Colors.red : Colors.amber,
      foregroundColor: isBookmarked ? Colors.white : Colors.black,
      icon: isBookmarked ? Icons.star : Icons.star_border,
      onTap: onTap,
    );
  }
}
