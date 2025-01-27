import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(HabitTrackApp());
}

class HabitTrackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HabitTrack+',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
