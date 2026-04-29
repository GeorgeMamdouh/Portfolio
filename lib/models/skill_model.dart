class Skill {
  final String name;
  final double percentage;

  const Skill({required this.name, required this.percentage});
}

class SkillCategory {
  final String title;
  final List<Skill> skills;

  const SkillCategory({required this.title, required this.skills});
}
