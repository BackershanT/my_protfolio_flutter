class Experience {
  final String id;
  final String company;
  final String role;
  final String duration;
  final String description;
  final List<String> achievements;
  final bool isCurrentJob;

  Experience({
    required this.id,
    required this.company,
    required this.role,
    required this.duration,
    required this.description,
    required this.achievements,
    this.isCurrentJob = false,
  });
}
