import '../database/habit_database.dart';

class HabitService {
  // Method to save a habit in the database
  Future<void> saveHabit(Map<String, dynamic> habit) async {
    await HabitDatabase.instance.insertHabit(habit);
  }

  Future<List<Map<String, dynamic>>> getHabits() async {
    return await HabitDatabase.instance.getHabits();
  }

  Future<void> clearHabits() async {
    // FOR TESTING CLEAR DB BUTTON
    await HabitDatabase.instance.clearDatabase();
  }

  Future<void> deleteHabit(int id, String userId) async {
    await HabitDatabase.instance.deleteHabit(id, userId);
  }
}
