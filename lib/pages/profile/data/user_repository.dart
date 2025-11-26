import 'dart:io';
import 'user_dao.dart';
import '../../../services/storage/image_storage_service.dart';

class UserRepository {
  Future<Map<String, dynamic>?> getProfile(String userId) {
    return UserDao().getProfile(userId);
  }

  Future<String> saveImage(File file, String userId) {
    return StorageService.saveProfileImage(file, userId);
  }

  Future<void> deleteImage(File file) {
    return StorageService.deleteProfileImage(file);
  }

  Future<void> saveProfile({
    required String userId,
    required String username,
    required String location,
    required String imagePath,
  }) {
    return UserDao().saveProfile(
      userId: userId,
      username: username,
      location: location,
      imagePath: imagePath,
    );
  }
}