import 'package:sqflite/sqflite.dart';
import '../../../database/app_database.dart';
import '../model/booking_model.dart';

class BookingDao {

  Future<void> insertBooking(BookingModel booking) async {
    final db = await AppDB.getDB();
    await db.insert(
      "bookings",
      booking.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> confirmBooking(String id) async {
    final db = await AppDB.getDB();
    await db.update(
      "bookings",
      {'isConfirmed': 1},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<List<BookingModel>> getBookings(String userId) async {
    final db = await AppDB.getDB();

    final res = await db.query(
      "bookings",
      where: "userId = ?",
      whereArgs: [userId],
    );

    return res.map((e) => BookingModel.fromMap(e)).toList();
  }

  Future<void> deleteBooking(String id) async {
    final db = await AppDB.getDB();
    await db.delete("bookings", where: "id = ?", whereArgs: [id]);
  }
}
