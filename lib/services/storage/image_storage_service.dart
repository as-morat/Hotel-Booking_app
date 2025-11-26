import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageService {
  static Future<String> saveProfileImage(File img, String userId) async {
    final dir = await getApplicationDocumentsDirectory();
    final ext = img.path.split('.').last;
    final path = "${dir.path}/profile_$userId.$ext";

    final saved = await img.copy(path);
    return saved.path;
  }

  static Future<void> deleteProfileImage(File img) async {
    try {
      if (await img.exists()) {
        await img.delete();
      }
    } catch (e) {
      throw e.toString();
    }
  }
}