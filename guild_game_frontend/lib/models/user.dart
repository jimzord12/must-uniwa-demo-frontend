class User {
  String userId;
  String name;
  int xp;
  String role;
  int successfulQuests;
  int failedQuests;
  String address;
  List<String> skills;
  List<dynamic> completedQuests; // Assuming IDs are strings
  List<dynamic> ongoingQuests; // Assuming IDs are strings
  List<dynamic> pendingReviewQuests; // Assuming IDs are strings
  List<dynamic> rejectedQuests; // Assuming IDs are strings

  User({
    required this.userId,
    required this.name,
    required this.xp,
    required this.role,
    required this.successfulQuests,
    required this.failedQuests,
    required this.address,
    required this.skills,
    required this.completedQuests,
    required this.ongoingQuests,
    required this.pendingReviewQuests,
    required this.rejectedQuests,
  });

  // Method to create a User object from a map (e.g., from JSON)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      name: json['name'],
      xp: json['xp'],
      role: json['role'],
      successfulQuests: json['successfulQuests'],
      failedQuests: json['failedQuests'],
      address: json['address'],
      skills: List<String>.from(json['skills']),
      completedQuests: List<String>.from(json['completedQuests']),
      ongoingQuests: List<String>.from(json['ongoingQuests']),
      pendingReviewQuests: List<String>.from(json['pendingReviewQuests']),
      rejectedQuests: List<String>.from(json['rejectedQuests']),
    );
  }

  // Method to convert User object to a map (e.g., for JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'xp': xp,
      'role': role,
      'successfulQuests': successfulQuests,
      'failedQuests': failedQuests,
      'address': address,
      'skills': skills,
      'completedQuests': completedQuests,
      'ongoingQuests': ongoingQuests,
      'pendingReviewQuests': pendingReviewQuests,
      'rejectedQuests': rejectedQuests,
    };
  }
}
