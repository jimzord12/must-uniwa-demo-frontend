import 'dart:math';

int convertRoleToNumber(String role) {
  if (role == 'student') {
    return 0;
  } else if (role == 'professor') {
    return 1;
  } else {
    throw ArgumentError('Invalid role');
  }
}

String randomName(String role) {
  final random = Random();
  final randomNumber =
      random.nextInt(99999); // Generates a random number up to 99999
  return '${role}_$randomNumber';
}
