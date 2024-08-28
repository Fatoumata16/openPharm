class Utilisateur {
  String nom;
  String prenom;
  int tel;
  String password;
  String sexe;

  Utilisateur({
    required this.nom,
    required this.prenom,
    required this.tel,
    required this.password,
    required this.sexe,
  });
  Utilisateur.forModification({
    required this.nom,
    required this.prenom,
    required this.tel,
    required this.sexe,
  }) : password = '';

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      nom: json['nom'],
      prenom: json['prenom'],
      tel: json['tel'],
      password: json['password'],
      sexe: json['sexe'],
    );
  }

  Map<String, dynamic> toJson() {
    final date = <String, dynamic>{};
    date['nom'] = nom;
    date['prenom'] = prenom;
    date['tel'] = tel;
    date['password'] = password;
    date['sexe'] = sexe;
    return date;
  }

  //  Map<String, dynamic> toJson() {
  //   final date = <String, dynamic>{};
  //   date['id_pharmacie'] = id_pharmacie;
  //   date['latitude'] = latitude;
  //   date['longitude'] = longitude;
  //   date['nom'] = nom;
  //   date['numero'] = numero;
  //   date['password'] = password;
  //   date['email'] = email;
  //   return date;
  // }

  // Ajoutez une méthode statique pour désérialiser une liste de données
  static List<Utilisateur> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((jsonData) => Utilisateur.fromJson(jsonData)).toList();
  }

  //...
}
