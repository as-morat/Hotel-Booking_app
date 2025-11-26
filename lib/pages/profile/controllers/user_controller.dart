import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/auth_provider/auth_provider.dart';
import '../data/user_repository.dart';

final profileControllerProvider =
    NotifierProvider<ProfileController, ProfileState>(() {
      return ProfileController();
    });

class ProfileState {
  final String username;
  final String location;
  final File? imageFile;
  final bool loading;

  ProfileState({
    this.username = "",
    this.location = "",
    this.imageFile,
    this.loading = false,
  });

  ProfileState copyWith({
    String? username,
    String? location,
    File? imageFile,
    bool clearImage = false,
    bool? loading,
  }) {
    return ProfileState(
      username: username ?? this.username,
      location: location ?? this.location,
      imageFile: clearImage ? null : (imageFile ?? this.imageFile),
      loading: loading ?? this.loading,
    );
  }
}

class ProfileController extends Notifier<ProfileState> {
  @override
  ProfileState build() {
    loadUser();
    return ProfileState();
  }

  UserRepository get repo => UserRepository();

  Future<void> loadUser() async {
    final user = ref.read(firebaseAuthProvider).currentUser!;
    final data = await repo.getProfile(user.uid);

    if (data != null) {
      state = state.copyWith(
        username: data['username'] ?? '',
        location: data['location'] ?? '',
        imageFile: (data['imagePath'] != null && data['imagePath'] != "")
            ? File(data['imagePath'])
            : null,
      );
    }
  }

  Future<void> updateImage(File file) async {
    final user = ref.read(firebaseAuthProvider).currentUser!;
    final savedPath = await repo.saveImage(file, user.uid);

    await repo.saveProfile(
      userId: user.uid,
      username: state.username,
      location: state.location,
      imagePath: savedPath,
    );

    state = state.copyWith(imageFile: File(savedPath));
  }

  Future<void> removeImage() async {
    final user = ref.read(firebaseAuthProvider).currentUser!;
    if (state.imageFile != null) {
      await repo.deleteImage(state.imageFile!);
    }

    await repo.saveProfile(
      userId: user.uid,
      username: state.username,
      location: state.location,
      imagePath: "",
    );

    state = state.copyWith(clearImage: true);
  }

  Future<void> updateText(String username, String location) async {
    final user = ref.read(firebaseAuthProvider).currentUser!;

    await repo.saveProfile(
      userId: user.uid,
      username: username,
      location: location,
      imagePath: state.imageFile?.path ?? "",
    );

    state = state.copyWith(username: username, location: location);
  }
}
