import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countdown_app/utils/colors.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/material.dart';

class TimeCard extends StatefulWidget {
  final DateTime dt;
  final String title;
  final String desc;
  final String id;
  const TimeCard(
      {super.key,
      required this.dt,
      required this.title,
      required this.desc,
      required this.id});

  @override
  State<TimeCard> createState() => _TimeCardState();
}

class _TimeCardState extends State<TimeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: tilesColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 80,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CountDownText(
              due: widget.dt,
              finishedText: "TimesUp at ${widget.dt.toString()}",
              showLabel: true,
              longDateName: true,
              daysTextLong: " DAYS ",
              hoursTextLong: " HOURS ",
              minutesTextLong: " MINUTES ",
              secondsTextLong: " SECONDS ",
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, bottom: 5),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey[800],
                        ),
                      ),
                      Container(height: 10),
                      Text(
                        widget.desc,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    iconSize: 40,
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("DateTime")
                          .doc(widget.id)
                          .delete();
                    },
                    icon: const Icon(Icons.delete)),
              ],
            ),
          ),
          Container(height: 5),
        ],
      ),
    );
  }
}
