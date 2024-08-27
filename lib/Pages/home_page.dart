import 'dart:async';
import 'package:clock_v2/Pages/Alarmset.dart';
import 'package:clock_v2/Pages/alarmFiles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class home_page extends StatefulWidget {
  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  String _currentSec = '';
  String _currentMin = '';
  String _currentHour = '';

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      _currentSec = '';
      _currentMin = '';
      _currentHour = '';

      setState(() {
        if (DateTime.now().second < 10) {
          _currentSec = "0";
        }
        _currentSec = _currentSec + DateTime.now().second.toString();
        if (DateTime.now().minute < 10) {
          _currentMin = "0";
        }
        _currentMin = _currentMin + DateTime.now().minute.toString().trim();
        if (DateTime.now().hour < 10) {
          _currentHour = "0";
        }
        _currentHour = _currentHour + DateTime.now().hour.toString().trim();
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
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
          CustomPaint(
            size: Size(size.width, 100),
            painter: topPainter(),
          ),
          Center(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width-100,
                    height: size.width-160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 20,
                            spreadRadius: 1,
                            blurStyle: BlurStyle.outer)
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 70,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Expanded(
                                flex:5,
                                child: SizedBox(
                                    height: 70,
                                    width: 60,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      alignment: Alignment.center,
                                      child: Text(
                                        _currentHour,
                                        style: GoogleFonts.oswald(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 70,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      ":",
                                      style: GoogleFonts.oswald(
                                        letterSpacing: 0,
                                        fontSize: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height: 70,
                                  width: 60,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    alignment: Alignment.center,
                                    child: Text(
                                      _currentMin,
                                      style: GoogleFonts.oswald(
                                        letterSpacing: 0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    fit: BoxFit.contain,
                                    child: Text(
                                      _currentSec,
                                      style: GoogleFonts.oswald(
                                        letterSpacing: 0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            DateTime.now().day.toString() +
                                "/" +
                                DateTime.now().month.toString() +
                                "/" +
                                DateTime.now().year.toString(),
                            style: GoogleFonts.oswald(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 30),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            DateTime.now().timeZoneName + " Time",
                            style: GoogleFonts.oswald(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: SizedBox(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return alarmSet();
                        },
                      ),
                    );
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
                        (states) => const Size(120, 60)),
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => const Color.fromARGB(255, 254, 149, 0)),
                    elevation: MaterialStateProperty.all(2),
                    shadowColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.black),
                    splashFactory: InkSparkle.splashFactory,
                  ),
                  child: const Icon(
                    Icons.alarm_add,
                    color: Colors.white,
                    size: 45,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: SizedBox(
                child: TextButton(
                  onPressed: () async{

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return alarmFiles();
                        },
                      ),
                    );
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
                            (states) => const Size(120, 60)),
                    backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => const Color.fromARGB(255, 254, 149, 0)),
                    elevation: MaterialStateProperty.all(2),
                    shadowColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.black),
                    splashFactory: InkSparkle.splashFactory,
                  ),
                  child: const Icon(
                    Icons.alarm,
                    color: Colors.white,
                    size: 45,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
