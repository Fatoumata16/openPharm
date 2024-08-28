import "package:flutter/material.dart";

import "assurance.dart";

class RechechePharmacie {
  int id_pharmacie;
  String nom_pharmacie;
  String image;
  String Contact_pharmacie;
  double latitude;
  double longitude;
  dynamic distance;
  List<Assurance> assurances; // Ajout de la liste d'assurances

  RechechePharmacie({
    required this.id_pharmacie,
    required this.nom_pharmacie,
    required this.image,
    required this.Contact_pharmacie,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.assurances, // Initialisation de la liste d'assurances
  });

  factory RechechePharmacie.fromJson(Map<String, dynamic> json) {
    var assuranceData = json['assurances'] as List<dynamic>? ?? [];
    List<Assurance> assurances = assuranceData
        .map((assurance) => Assurance.fromJson(assurance))
        .toList();

    return RechechePharmacie(
      id_pharmacie: json['id_pharmacie'],
      nom_pharmacie: json['nom_pharmacie'],
      image: json['image'],
      Contact_pharmacie: json['Contact_pharmacie'].toString(),
      latitude: json['latitude'],
      longitude: json['longitude'],
      distance: json['distance'],
      assurances:
          assurances, // Assurez-vous que cette liste est correctement remplie
    );
  }
}
