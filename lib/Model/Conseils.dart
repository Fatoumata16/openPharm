class Conseils {
  final int id;
  final String description;
  final String date;
  final String path;

  Conseils({
    required this.id,
    required this.description,
    required this.date,
    required this.path,
  });

  factory Conseils.fromJson(Map<String, dynamic> json) {
    return Conseils(
      id: json['id_conseil'] as int,
      description: json['description'] as String,
      date: json['date'] as String,
      path: json['path'] as String,
    );
  }
}