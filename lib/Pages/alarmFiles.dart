import 'package:clock_v2/Pages/Alarmset.dart';
import 'package:clock_v2/Pages/home_page.dart';
import 'package:clock_v2/database.dart';
import 'package:clock_v2/localNotifications.dart';
import 'package:clock_v2/taskTiles.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class alarmFiles extends StatefulWidget {
  alarmFiles({super.key});

  @override
  State<alarmFiles> createState() => _alarmFilesState();
}

class _alarmFilesState extends State<alarmFiles> {
  final _myBox = Hive.box('myBox');
  database db = database();

  @override
  void initState() {
    // TODO: implement initState
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            heightFactor: 1,
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [Colors.white10, Color.fromARGB(100, 254, 149, 0)],
                  radius: 0.9,
                ),
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 90,
              ),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: ListView.builder(
                    physics: PageScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: db.todoList.length,
                    itemBuilder: (context, index) {
                      return taskTile(
                        on_off: db.todoList[index][1],
                        time: converter.epochToString(db.todoList[index][0]),
                        index: index,
                        alarmList: db.todoList,
                        deleteTask: (value) {
                          setState(() {
                            db.todoList.removeAt(index);
                          });
                          db.updateDataBase();
                        },
                        alarm_on_off: (p0) {
                          setState(() {
                            db.todoList[index][1] = !db.todoList[index][1];
                          });
                          db.updateDataBase();

                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          CustomPaint(
            size: Size(size.width, 100),
            painter: topPainter(),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return home_page();
                  },
                ));
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 30,
              ),
              style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
            ),
          )
        ],
      ),
    );
  }
}

class converter {
  static String epochToString(
    int milliseconds,
  ) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String ampm = hour < 12 ? "AM" : "PM";
    hour = hour % 12;
    String hourString = hour == 0 ? "12" : hour.toString();
    String minuteString = minute < 10 ? "0$minute" : minute.toString();
    String timeString = "$hourString:$minuteString $ampm";
    return timeString;
  }

  static int stringtoEpoch(String timeString) {
    List<String> timeParts = timeString.split(" ");
    String timePart = timeParts[0];
    String ampm = timeParts[1];
    List<String> timeComponents = timePart.split(":");
    int hour = int.parse(timeComponents[0]);
    int minute = int.parse(timeComponents[1]);
    if (ampm == "PM" && hour != 12) {
      hour += 12;
    }
    DateTime dateTime = DateTime(1970, 1, 1, hour, minute);
    int milliseconds = dateTime.millisecondsSinceEpoch;
    return milliseconds; // prints the number of milliseconds since the Unix epoch
  }
}
