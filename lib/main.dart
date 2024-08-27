import 'package:clock_v2/Pages/Alarmset.dart';
import 'package:clock_v2/Pages/home_page.dart';
import 'package:clock_v2/localNotifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:alarm/alarm.dart';



void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox("myBox");
  await Alarm.init();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const myApp());

}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do Bro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.robotoCondensedTextTheme(),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color.fromARGB(255, 254, 149, 0)),
      home: home_page(),
    );
  }
}

