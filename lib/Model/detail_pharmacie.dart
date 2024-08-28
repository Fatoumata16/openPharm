import "package:flutter/material.dart";


class InfoPharmacie {
  final double latitude;
  final double longitude;
  final String path;
  final int numero;
  final String nom;
  final List<String> jours;
  final List<Assurance> assurances;

  InfoPharmacie({
    required this.latitude,
    required this.longitude,
    required this.path,
    required this.numero,
    required this.nom,
    required this.jours,
    required this.assurances,
  });

  factory InfoPharmacie.fromJson(Map<String, dynamic> json) {
    final joursList = (json['jours'] as List<dynamic>)
        .map((item) => item['nom'].toString())
        .toList();
    final assurancesList = (json['assurances'] as List<dynamic>)
        .map((item) => Assurance.fromJson(item as Map<String, dynamic>))
        .toList();

    return InfoPharmacie(
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      path: json['path'].toString(),
      numero: json['numero'] as int,
      nom: json['nom'].toString(),
      jours: joursList,
      assurances: assurancesList,
    );
  }
}

class Assurance {
  final String libelle;
  final String adresse;
  final String tel;

  Assurance({
    required this.libelle,
    required this.adresse,
    required this.tel,
  });

  factory Assurance.fromJson(Map<String, dynamic> json) {
    return Assurance(
      libelle: json['libelle'].toString(),
      adresse: json['adresse'].toString(),
      tel: json['tel'],
    );
  }
}
