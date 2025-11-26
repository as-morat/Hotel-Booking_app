class UserProfile {
  final String userId;
  final String username;
  final String location;
  final String imagePath;

  UserProfile({
    required this.userId,
    required this.username,
    required this.location,
    required this.imagePath,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      userId: map['userId'] as String,
      username: map['username'] as String? ?? '',
      location: map['location'] as String? ?? '',
      imagePath: map['imagePath'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'location': location,
      'imagePath': imagePath,
    };
  }

  UserProfile copyWith({
    String? userId,
    String? username,
    String? location,
    String? imagePath,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      location: location ?? this.location,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}