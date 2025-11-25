import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDB {
  static Database? _db;

  static Future<Database> getDB() async {
    if (_db != null) return _db!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "app.db");

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""
          CREATE TABLE user_profile (
            userId TEXT PRIMARY KEY,
            username TEXT,
            location TEXT,
            imagePath TEXT
          );
        """);

        // await db.execute("""
        //   CREATE TABLE bookings (
        //     id TEXT PRIMARY KEY,
        //     userId TEXT,
        //     title TEXT,
        //     price TEXT,
        //     location TEXT
        //   );
        // """);
      },
    );

    return _db!;
  }

  static Future<void> closeDB() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }
}