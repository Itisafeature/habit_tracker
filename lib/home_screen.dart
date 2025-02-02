import 'package:flutter/material.dart';
import 'habit_creation_screen.dart';
import '../services/habit_service.dart';

const String currentUserId =
    "test_user"; // Placeholder until authentication is added

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> habits = []; // List to store habits
  late final HabitService habitService;

  @override
  void initState() {
    super.initState();
    habitService = HabitService();
    _loadHabits(); // Fetch habits when the screen loads
  }

  // Fetch habits from SQLite and update the UI
  Future<void> _loadHabits() async {
    final loadedHabits = await habitService.getHabits();

    setState(() {
      habits = loadedHabits;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HabitTrack+'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await habitService.clearHabits();
              _loadHabits(); // Refresh UI
            },
          ),
        ],
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
                  key: ValueKey(habit['id']), // Keeps track of unique items
                  title: Text(habit['name']),
                  subtitle: Text(habit['frequency']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await habitService.deleteHabit(
                          habit['id'], currentUserId);
                      _loadHabits(); // Refresh UI after deletion
                    },
                  ),
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
            _loadHabits(); // Reload habits from database
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
