import 'dart:async';
import 'dart:ui';
import 'package:clock_v2/Pages/alarmFiles.dart';
import 'package:clock_v2/Pages/home_page.dart';
import 'package:clock_v2/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class alarmSet extends StatefulWidget {
  alarmSet() {
    super.key;
  }

  @override
  State<alarmSet> createState() => _alarmSetState();
}

class _alarmSetState extends State<alarmSet> {
  var min = 0;
  var hour = 1;
  bool ampressed = () {
    if (DateTime.now().hour < 12) {
      return true;
    }
    return false;
  }.call();
  bool pmpressed = () {
    if (DateTime.now().hour >= 12) {
      return true;
    }
    return false;
  }.call();

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

  String merdium() {
    if (ampressed)
      return "AM";
    else
      return "PM";
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 149, 0),
      body: Stack(
        children: [
          Center(
            heightFactor: 0.9,
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [Colors.white38, Color.fromARGB(100, 254, 149, 0)],
                  radius: 0.8,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.topCenter,
              height: 100,
              width: size.width,
              child: Stack(
                children: [
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
                      style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              width: size.width,
              child: Stack(children: [
                CustomPaint(
                  size: Size(size.width, 100),
                  painter: bottomPainter(),
                ),
                Center(
                    heightFactor: 0.299,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54,
                              blurRadius: 7,
                              spreadRadius: 3)
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          String time = "$hour:$min ${merdium()}";
                          int _epoch = converter.stringtoEpoch(time);
                          db.todoList.add([_epoch, true]);
                          db.updateDataBase();

                          Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) {
                              return home_page();
                            },
                          ));
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const CircleBorder(
                                side: BorderSide(
                                    style: BorderStyle.solid,
                                    color: Colors.white,
                                    width: 3.5),
                                eccentricity: 0),
                          ),
                          fixedSize: MaterialStateProperty.resolveWith(
                              (states) => const Size(130, 65)),
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) =>
                                  const Color.fromARGB(255, 254, 149, 0)),
                          elevation: MaterialStateProperty.all(2),
                          shadowColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.black),
                          splashFactory: InkSparkle.splashFactory,
                        ),
                        child: Text(
                          "SET",
                          style: GoogleFonts.oswald(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )),
              ]),
            ),
          ),
          Positioned(
            top: size.height / 6,
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        ampressed = !ampressed;
                        if (pmpressed) {
                          pmpressed = !pmpressed;
                        }
                      },
                    );
                  },
                  style:
                      const ButtonStyle(splashFactory: NoSplash.splashFactory),
                  child: Text(
                    "A.M",
                    style: GoogleFonts.oswald(
                        color: ampressed ? Colors.black54 : Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        shadows: [
                          const Shadow(
                              color: Colors.black54,
                              offset: Offset(0, 1),
                              blurRadius: 2)
                        ]),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        pmpressed = !pmpressed;
                        if (ampressed) {
                          ampressed = !ampressed;
                        }
                      },
                    );
                  },
                  style:
                      const ButtonStyle(splashFactory: NoSplash.splashFactory),
                  child: Text(
                    "P.M",
                    style: GoogleFonts.oswald(
                        color: pmpressed ? Colors.black54 : Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        shadows: [
                          const Shadow(
                              color: Colors.black54,
                              offset: Offset(0, 1),
                              blurRadius: 2)
                        ]),
                  ),
                )
              ],
            ),
          ),
          Center(
            heightFactor: 0.89,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: size.width - 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 20,
                              spreadRadius: 1,
                              blurStyle: BlurStyle.outer)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Set Alarm",
                          style: GoogleFonts.oswald(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 30,
                              height: -3.4),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 70,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height: 70,
                                  width: size.width - 100,
                                  child: ListWheelScrollView.useDelegate(
                                    itemExtent: 90,
                                    perspective: 0.009,
                                    diameterRatio: 10,
                                    physics: const FixedExtentScrollPhysics(),
                                    onSelectedItemChanged: (value) =>
                                        hour = value + 1,
                                    childDelegate:
                                        ListWheelChildLoopingListDelegate(
                                      children: List.generate(12, (index) {
                                        String extra = "";
                                        if (index + 1 < 10) {
                                          extra = "0";
                                        }
                                        return FittedBox(
                                          child: Text(
                                            extra + "${index + 1}",
                                            style: GoogleFonts.oswald(
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  ":",
                                  style: GoogleFonts.oswald(
                                    letterSpacing: 0,
                                    fontSize: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height: 70,
                                  child: ListWheelScrollView.useDelegate(
                                    overAndUnderCenterOpacity: 0.1,
                                    itemExtent: 90,
                                    perspective: 0.009,
                                    diameterRatio: 10,
                                    physics: const FixedExtentScrollPhysics(),
                                    onSelectedItemChanged: (value) =>
                                        min = value,
                                    childDelegate:
                                        ListWheelChildLoopingListDelegate(
                                      children: List.generate(60, (index) {
                                        String extra = "";
                                        if (index < 10) {
                                          extra = "0";
                                        }
                                        return FittedBox(
                                          child: Text(
                                            extra + "${index}",
                                            style: GoogleFonts.oswald(
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Alarm Time",
                          style: GoogleFonts.oswald(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class topPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.lineTo(0, 60);
    path.arcToPoint(Offset(size.width, 60),
        radius: const Radius.elliptical(0.1, 0.03), clockwise: false);
    path.lineTo(size.width, 0);
    Path shadow_path = path.shift(const Offset(0, 2));

    canvas.drawShadow(shadow_path, Colors.black, 4, true);
    canvas.drawPath(path, paint);
    path.close();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class bottomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path()..moveTo(0, 40);
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 10);
    path.arcToPoint(Offset(size.width * 0.60, 10),
        radius: const Radius.circular(10), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 40);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    Path shadow_path = path.shift(const Offset(0, -8));
    canvas.drawShadow(shadow_path, Colors.black, 4, true);
    canvas.drawPath(path, paint);
    path.close();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
