import 'package:flutter/material.dart';
import '../database/habit_database.dart';
// import 'package:habittrack/database/habit_database.dart';

class HabitCreationScreen extends StatefulWidget {
  @override
  _HabitCreationScreenState createState() => _HabitCreationScreenState();
}

class _HabitCreationScreenState extends State<HabitCreationScreen> {
  TextEditingController habitNameController = TextEditingController();
  TextEditingController customIntervalController = TextEditingController();
  String selectedFrequency = 'Daily'; // Default frequency option

  @override
  void dispose() {
    habitNameController.dispose();
    customIntervalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Habit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: habitNameController,
              decoration: InputDecoration(
                labelText: 'Habit Name',
                border: OutlineInputBorder(),
                hintText: 'e.g., Drink Water',
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Frequency',
                border: OutlineInputBorder(),
              ),
              value: selectedFrequency,
              items: [
                DropdownMenuItem(value: 'Hourly', child: Text('Hourly')),
                DropdownMenuItem(value: 'Daily', child: Text('Daily')),
                DropdownMenuItem(value: 'Weekly', child: Text('Weekly')),
                DropdownMenuItem(value: 'Monthly', child: Text('Monthly')),
                DropdownMenuItem(value: 'Custom', child: Text('Custom')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedFrequency = value!;
                });
              },
            ),
            SizedBox(height: 16),
            if (selectedFrequency == 'Custom')
              TextField(
                controller: customIntervalController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Custom Interval (in hours)',
                  border: OutlineInputBorder(),
                  hintText: 'Enter a number',
                ),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (!isHabitNameValid() || !isFrequencyValid()) return;

                String habitName = habitNameController.text.trim();
                String frequency = selectedFrequency == 'Custom'
                    ? '${customIntervalController.text.trim()} hours'
                    : selectedFrequency;

                final habit = {
                  'name': habitName,
                  'frequency': frequency,
                };

                // Save habit in the database
                await HabitDatabase.instance.insertHabit(habit);

                if (!context.mounted) return;

                Navigator.pop(context, habit);
              },
              child: Text('Save Habit'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Methods - These stay within the _HabitCreationScreenState class
  bool isHabitNameValid() {
    String habitName = habitNameController.text.trim();
    if (habitName.isEmpty) {
      showError('Please enter a habit name');
      return false;
    }
    return true;
  }

  bool isFrequencyValid() {
    if (selectedFrequency.isEmpty) {
      showError('Please select a frequency');
      return false;
    }
    if (selectedFrequency == 'Custom') {
      String customInterval = customIntervalController.text.trim();
      if (customInterval.isEmpty) {
        showError('Please enter a custom interval');
        return false;
      }
      final customIntervalValue = double.tryParse(customInterval);
      if (customIntervalValue == null || customIntervalValue <= 0) {
        showError('Custom interval must be a positive number');
        return false;
      }
    }
    return true;
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
