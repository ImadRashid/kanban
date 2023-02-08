class AppUser {
  String? userId;
  String? userName;
  String? email;
  String? userImageUrl;
  String? description;
  DateTime? createdAt;
  String? phoneNumber;
  bool? isProfileCompleted;

  AppUser({
    this.email,
    this.userImageUrl,
    this.userName,
    this.description,
    this.userId,
    this.phoneNumber,
    this.createdAt,
    this.isProfileCompleted,
  });

  AppUser.fromJson(json, id) {
    userId = id;
    userName = json['userName'] ?? null;
    email = json['email'] ?? null;
    description = json['description'] ?? null;
    userImageUrl = json['userImageUrl'] ?? null;
    phoneNumber = json['phoneNumber'] ?? null;
    createdAt = json['createdAt'].toDate();
    isProfileCompleted = json['isProfileCompleted'] ?? null;
  }

  toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'email': email,
      'description': description,
      'userImageUrl': userImageUrl,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt,
      'isProfileCompleted': isProfileCompleted,
    };
  }
}
