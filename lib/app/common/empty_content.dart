import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({
    Key key,
    this.title = 'Nothing here',
    this.message = 'Update the page',
    this.showRefreshButton = false,
    this.onRefreshPressed,
  }) : super(key: key);

  final String title;
  final String message;
  final bool showRefreshButton;
  final VoidCallback onRefreshPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 32, color: Colors.black54),
          ),
          Text(
            message,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          if (showRefreshButton && onRefreshPressed != null)
            IconButton(
              iconSize: 44,
              color: Colors.green,
              icon: Icon(Icons.refresh),
              onPressed: onRefreshPressed,
            )
        ],
      ),
    );
  }
}
