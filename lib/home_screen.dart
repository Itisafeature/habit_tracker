import 'package:flutter/material.dart';
import 'habit_creation_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HabitTrack+'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Drink Water'),
            subtitle: Text('Daily'),
            trailing: Icon(Icons.check_circle_outline),
          ),
          ListTile(
            title: Text('Exercise'),
            subtitle: Text('Weekly'),
            trailing: Icon(Icons.check_circle_outline),
          ),
          ListTile(
            title: Text('Read a Book'),
            subtitle: Text('Daily'),
            trailing: Icon(Icons.check_circle_outline),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HabitCreationScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
