class Certification {
  final String name;
  final String authority;
  final String date;
  final String imageUrl;
  final String? certificateUrl;

  Certification({
    required this.name,
    required this.authority,
    required this.date,
    required this.imageUrl,
    this.certificateUrl,
  });
}
