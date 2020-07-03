import 'package:bandhunew/Classes/Activity.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatefulWidget {
  Activity activity;
  ActivityCard(this.activity);
  @override
  _ActivityCardState createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: double.infinity,
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          Text(widget.activity.name),
          Text(widget.activity.rawMaterial),
          Text(widget.activity.avgProduction),
        ],
      ),
    );
  }
}
