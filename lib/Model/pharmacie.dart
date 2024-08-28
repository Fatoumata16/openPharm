import "package:flutter/material.dart";

class Pharmacie {
  int? id_pharmacie;
  String nom;
  int numero;
  String password;
  String? path;
  double latitude;
  double longitude;
  String email;
  String etat;

  Pharmacie({
    this.id_pharmacie,
    required this.nom,
    required this.numero,
    required this.password,
    this.path,
    required this.latitude,
    required this.longitude,
    required this.email,
    required this.etat,
  });

  factory Pharmacie.fromJson(Map<String, dynamic> json) {
    return Pharmacie(
      id_pharmacie: json['id_pharmacie'],
      nom: json['nom'],
      numero: json['numero'],
      password: json['password'],
      path: json['path'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      email: json['email'],
      etat: json['etat'],
    );
  }

  Map<String, dynamic> toJson() {
    final date = <String, dynamic>{};
    date['id_pharmacie'] = id_pharmacie;
    date['latitude'] = latitude;
    date['longitude'] = longitude;
    date['nom'] = nom;
    date['numero'] = numero;
    date['password'] = password;
    date['email'] = email;
    return date;
  }
}
