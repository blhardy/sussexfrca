import 'package:flutter/material.dart';

class DownArrowBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 5),
      color: Colors.cyan[100]!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Show Options"),
          Icon(Icons.add_circle_outline_rounded)
        ],
      ),
    );
  }
}

class UpArrowBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.amber[100]!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Text("Hide Options"), Icon(Icons.arrow_upward_rounded)],
      ),
    );
  }
}

class ArrowBar extends StatelessWidget {
  final bool _expanded;
  ArrowBar(this._expanded);

  @override
  Widget build(BuildContext context) => Card(
        margin: EdgeInsets.only(top: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // if you need this
          side: BorderSide(
            color: Colors.grey.withOpacity(0.4),
            width: 2,
          ),
        ),
        color: Colors.blue[600]!,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(""),
            Text(getArrowBarText(_expanded),
                style: TextStyle(color: Colors.white)),
            Icon(
              getArrowBarIcon(_expanded),
              color: Colors.white,
            )
          ],
        ),
      );

  // ignore: empty_constructor_bodies
  String getArrowBarText(bool _expanded) {
    if (_expanded) {
      return "Hide Options";
    } else {
      return "Show Options";
    }
  }

  IconData getArrowBarIcon(bool _expanded) {
    if (_expanded) {
      return Icons.remove_circle_outline_rounded;
    } else {
      return Icons.add_circle_outline_rounded;
    }
  }
}
