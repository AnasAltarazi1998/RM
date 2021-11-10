import 'package:flutter/material.dart';

class ExpandingFab extends StatefulWidget {
  @override
  _ExpandingFabState createState() => _ExpandingFabState();
}

class _ExpandingFabState extends State<ExpandingFab> {
  bool _cardIsOpen = false;
  double get cardWidth => MediaQuery.of(context).size.width - 32;
  double cardHeight = 200;

  Widget _renderFab() {
    return InkWell(
      onTap: () {
        setState(() {
          _cardIsOpen = true;
        });
      },
      child: Icon(Icons.add, color: Colors.white),
    );
  }

  Widget _renderUpsertEntryCard() {
    return Container(
      width: cardWidth,
      height: cardHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Hello, World!'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _cardIsOpen = false;
              });
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = _cardIsOpen ? cardWidth : 56;
    double h = _cardIsOpen ? cardHeight : 56;

    return AnimatedContainer(
      curve: Curves.ease,
      constraints: BoxConstraints(
        minWidth: w,
        maxWidth: w,
        minHeight: h,
        maxHeight: h,
      ),
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: _cardIsOpen ? Colors.blueGrey[100] : Colors.blue,
        boxShadow: kElevationToShadow[1],
        borderRadius: _cardIsOpen
            ? BorderRadius.all(Radius.circular(0.0))
            : BorderRadius.all(Radius.circular(50)),
      ),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: !_cardIsOpen ? _renderFab() : _renderUpsertEntryCard(),
      ),
    );
  }
}
