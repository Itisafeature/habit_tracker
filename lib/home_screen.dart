import 'package:flutter/material.dart';

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
          // Navigate to habit creation screen (to be implemented later)
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
