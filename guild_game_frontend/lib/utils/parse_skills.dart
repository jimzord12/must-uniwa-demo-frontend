List<String> parseSkills(String skills) {
  return skills.split(',').map((skill) => skill.trim()).toList();
}

String skillsToString(List<String> skills) {
  return skills.join(', ');
}
