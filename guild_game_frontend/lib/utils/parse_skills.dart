List<String> parseSkills(String skills) {
  return skills.split(',').map((skill) => skill.trim()).toList();
}
