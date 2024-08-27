import 'package:clock_v2/Pages/alarmFiles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class taskTile extends StatelessWidget {
  final String time;
  bool on_off;
  int index;
  List alarmList;
  final void Function(BuildContext)? deleteTask;
  final void Function(bool)? alarm_on_off;

  taskTile({
    super.key,
    required this.time,
    required this.on_off,
    required this.index,
    required this.alarmList,
    required this.deleteTask,
    required this.alarm_on_off,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 20, 15),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteTask,
            icon: Icons.delete,
            autoClose: true,
            backgroundColor: Colors.black54,
            borderRadius: BorderRadius.circular(12),
          )
        ]),
        child: Container(
          height: 75,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.elliptical(0, 10)),
              border: Border(
                right: BorderSide.none,
                bottom: BorderSide(width: 1, color: Colors.white),
              )),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Icon(
                      Icons.notifications_on_outlined,
                      size: 35,
                      color: on_off ? Colors.white : Colors.black38,
                    ),
                  ),
                  Text(
                    time,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.oswald(
                        decorationThickness: 2,
                        decorationColor: Colors.black87,
                        fontSize: 29,
                        // fontWeight: FontWeight.bold,
                        color: on_off ? Colors.white : Colors.black38),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Switch(
                        value: on_off,
                        onChanged: alarm_on_off,
                        inactiveTrackColor: Colors.black,
                        activeTrackColor: Colors.black,
                        activeColor: Colors.white,
                        trackOutlineColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.black),
                      ),
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
