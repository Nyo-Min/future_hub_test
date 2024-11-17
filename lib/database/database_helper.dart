import 'package:path/path.dart';
import 'package:future_hub_test/database/appointment_manager.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static const String dbName = 'appointments.db';

  // Create a singleton pattern for DatabaseHelper
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  static Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Create the appointments table
  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE appointments (
        id INTEGER PRIMARY KEY,
        title TEXT,
        customer_name TEXT,
        company TEXT,
        appointment_description TEXT,
        appointment_date_time TEXT,
        latitude REAL,
        longitude REAL
      )
    ''');
  }

  // Insert an appointment into the database
  static Future<void> insertAppointment(Appointment appointment) async {
    final db = await database;
    await db.insert(
      'appointments',
      appointment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace if the appointment already exists
    );
  }

  // Get all appointments from the database
  static Future<List<Appointment>> getAppointments() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('appointments');

    return List.generate(maps.length, (i) {
      return Appointment.fromMap(maps[i]);
    });
  }

  // Close the database
  static Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
  }
}
