class UserResponse {
  final String id;
  final String userId;
  final String name;
  final int xp;
  final String role;
  final int successfulQuests;
  final int failedQuests;
  final String address;
  final List<String> completedQuests;
  final List<String> ongoingQuests;
  final List<String> pendingReviewQuests;
  final List<String> rejectedQuests;
  final int v;
  final List<String> skills;

  UserResponse({
    required this.id,
    required this.userId,
    required this.name,
    required this.xp,
    required this.role,
    required this.successfulQuests,
    required this.failedQuests,
    required this.address,
    required this.completedQuests,
    required this.ongoingQuests,
    required this.pendingReviewQuests,
    required this.rejectedQuests,
    required this.v,
    required this.skills,
  });

  // From JSON
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['_id'],
      userId: json['userId'],
      name: json['name'],
      xp: json['xp'],
      role: json['role'],
      successfulQuests: json['successfulQuests'],
      failedQuests: json['failedQuests'],
      address: json['address'],
      completedQuests: List<String>.from(json['completedQuests']),
      ongoingQuests: List<String>.from(json['ongoingQuests']),
      pendingReviewQuests: List<String>.from(json['pendingReviewQuests']),
      rejectedQuests: List<String>.from(json['rejectedQuests']),
      v: json['__v'],
      skills: List<String>.from(json['skills']),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'name': name,
      'xp': xp,
      'role': role,
      'successfulQuests': successfulQuests,
      'failedQuests': failedQuests,
      'address': address,
      'completedQuests': completedQuests,
      'ongoingQuests': ongoingQuests,
      'pendingReviewQuests': pendingReviewQuests,
      'rejectedQuests': rejectedQuests,
      '__v': v,
      'skills': skills,
    };
  }
}
