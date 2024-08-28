class Assurance {
  int id_assurance;
  String libelle;

  Assurance({
    required this.id_assurance,
    required this.libelle,
  });

  factory Assurance.fromJson(Map<String, dynamic> json) {
    return Assurance(
      id_assurance: json['id_assurance'],
      libelle: json['libelle'],
    );
  }
}
