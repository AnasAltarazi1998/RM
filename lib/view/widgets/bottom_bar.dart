import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/InfoScreen');
              },
              icon: Icon(Icons.info),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/SettingsScreen');
              },
              icon: Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
