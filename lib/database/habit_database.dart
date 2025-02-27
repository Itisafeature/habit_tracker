import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class HabitDatabase {
  static final HabitDatabase instance = HabitDatabase._init();
  static Database? _database;

  HabitDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('habits.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE habits (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId TEXT NOT NULL,
        name TEXT NOT NULL,
        frequency TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertHabit(Map<String, dynamic> habit) async {
    final db = await instance.database;
    return await db.insert('habits', habit);
  }

  Future<List<Map<String, dynamic>>> getHabits() async {
    final db = await instance.database;
    return await db.query('habits');
  }

  Future<void> deleteHabit(int id, String userId) async {
    final db = await instance.database;
    await db.delete('habits',
        where: 'id = ? AND userId = ?', whereArgs: [id, userId]);
  }

  Future<void> updateHabit(int id, Map<String, dynamic> updatedHabit) async {
    final db = await instance.database;
    await db.update('habits', updatedHabit, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> clearDatabase() async {
    final db = await instance.database;
    await db.delete('habits'); // Deletes all rows in the habits table
  }
}
