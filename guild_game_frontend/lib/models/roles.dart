enum Roles { professor, student }

extension RoleExtension on Roles {
  String get value {
    switch (this) {
      case Roles.professor:
        return 'professor';
      case Roles.student:
        return 'student';
    }
  }

  static Roles fromValue(String value) {
    switch (value) {
      case 'professor':
        return Roles.professor;
      case 'student':
        return Roles.student;
      default:
        throw FormatException(
            'Invalid role: $value'); // Or throw an exception, depending on your error handling strategy
    }
  }
}
