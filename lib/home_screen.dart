import 'package:flutter/material.dart';
import 'habit_creation_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> habits = []; // List to store habits

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HabitTrack+'),
        centerTitle: true,
      ),
      body: habits.isEmpty
          ? Center(
              child: Text(
                'No habits added yet. Tap + to create one!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                final habit = habits[index];
                return ListTile(
                  title: Text(habit['name']!),
                  subtitle: Text(habit['frequency']!),
                  trailing: Icon(Icons.check_circle_outline),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newHabit = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HabitCreationScreen()),
          );

          if (newHabit != null) {
            setState(() {
              habits.add(newHabit);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
