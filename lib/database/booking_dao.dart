import 'package:sqflite/sqflite.dart';
import 'app_database.dart';

class BookingDao {
  Future<void> saveBooking({
    required String id,
    required String userId,
    required String title,
    required String price,
    required String location,
  }) async {
    final db = await AppDB.getDB();

    await db.insert(
      "bookings",
      {
        "id": id,
        "userId": userId,
        "title": title,
        "price": price,
        "location": location,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getBookings(String userId) async {
    final db = await AppDB.getDB();

    final res = await db.query(
      "bookings",
      where: "userId = ?",
      whereArgs: [userId],
    );

    return res;
  }

  Future<void> deleteBooking(String id) async {
    final db = await AppDB.getDB();

    await db.delete(
      "bookings",
      where: "id = ?",
      whereArgs: [id],
    );
  }
}