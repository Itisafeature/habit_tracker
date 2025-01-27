import 'package:flutter/material.dart';

class HabitCreationScreen extends StatefulWidget {
  @override
  _HabitCreationScreenState createState() => _HabitCreationScreenState();
}

class _HabitCreationScreenState extends State<HabitCreationScreen> {
  String selectedFrequency = 'Daily'; // Default selection
  TextEditingController customIntervalController = TextEditingController();

  @override
  void dispose() {
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
              decoration: InputDecoration(
                labelText: 'Habit Name',
                border: OutlineInputBorder(),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: customIntervalController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Custom Interval (in hours)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Example: Enter "3" for every 3 hours.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Save the habit with the selected frequency
                String habitFrequency = selectedFrequency == 'Custom'
                    ? '${customIntervalController.text} hours'
                    : selectedFrequency;
                print('Habit Frequency: $habitFrequency');
                Navigator.pop(context); // Return to the home screen
              },
              child: Text('Save Habit'),
            ),
          ],
        ),
      ),
    );
  }
}
