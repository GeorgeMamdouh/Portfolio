class Project {
  final String id;
  final String title;
  final String tech;
  final String description;
  final String imageUrl;
  final String? projectUrl;
  final String? githubUrl;
  final List<String> highlights;

  const Project({
    required this.id,
    required this.title,
    required this.tech,
    required this.description,
    required this.imageUrl,
    this.projectUrl,
    this.githubUrl,
    this.highlights = const [],
  });
}
