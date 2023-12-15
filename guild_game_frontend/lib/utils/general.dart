import 'dart:math';

BigInt convertRoleToNumber(String role) {
  if (role == 'student') {
    return BigInt.from(0);
  } else if (role == 'professor') {
    return BigInt.from(1);
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
