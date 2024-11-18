import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

import 'appointment_manager.dart';

class LocalDatabase {
  static Database? _database;

  // Initialize the SQLite database
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  static Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'appointments.db'); // SQLite database path
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Create table schema for appointments
  static void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE appointments(
        id TEXT PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        customerName TEXT,
        company TEXT,
        description TEXT,
        appointmentDateTime TEXT,
        latitude REAL,
        longitude REAL
      )
    ''');
  }

  // Insert appointment into the database
  static Future<int> insertAppointment(Appointment appointment) async {
    final db = await database;
    return await db.insert(
      'appointments',
      appointment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // If conflict, replace the existing data
    );
  }

  // Get all appointments from the database
  static Future<List<Appointment>> getAllAppointments() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('appointments');
    return List.generate(maps.length, (i) {
      return Appointment.fromMap(maps[i]);
    });
  }

  // Get appointment by ID
  static Future<Appointment?> getAppointmentById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'appointments',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Appointment.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Update appointment by ID
  static Future<int> updateAppointment(Appointment appointment) async {
    final db = await database;
    return await db.update(
      'appointments',
      appointment.toMap(),
      where: 'id = ?',
      whereArgs: [appointment.id],
    );
  }

  // Delete appointment by ID
  static Future<int> deleteAppointment(int id) async {
    final db = await database;
    return await db.delete(
      'appointments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete all appointments from the database
  static Future<int> deleteAllAppointments() async {
    final db = await database;
    int deletedCount = await db.delete('appointments');
    // return await db.delete('appointments');
    await db.rawQuery('UPDATE sqlite_sequence SET seq = 1 WHERE name = "appointments"');
    return deletedCount;
  }
}
