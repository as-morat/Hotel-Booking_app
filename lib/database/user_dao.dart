import 'app_database.dart';

class UserDao {
  Future<void> saveProfile({
    required String userId,
    required String username,
    required String location,
    required String imagePath,
  }) async {
    final db = await AppDB.getDB();

    await db.insert(
      "user_profile",
      {
        "userId": userId,
        "username": username,
        "location": location,
        "imagePath": imagePath,
      },
      conflictAlgorithm: .replace,
    );
  }

  Future<Map<String, dynamic>?> getProfile(String userId) async {
    final db = await AppDB.getDB();

    final res = await db.query(
      "user_profile",
      where: "userId = ?",
      whereArgs: [userId],
    );

    if (res.isEmpty) return null;
    return res.first;
  }
}
