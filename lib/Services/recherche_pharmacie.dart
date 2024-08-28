import "dart:convert";
import "package:flutter/material.dart";
import "../Model/detail_pharmacie.dart";
import "../Model/pharmacie.dart";
import "../utils/env.dart";
import 'package:http/http.dart' as http;

class RechercheService {
  static String baseUrl =
      ApiUrl.baseUrl; // Assurez-vous d'importer correctement ApiUrl

  Future<List<Pharmacie>> rechercheParNom(String query) async {
    try {
      final response = await http.get(
          Uri.parse('${ApiUrl.baseUrl}pharmacie/rechercherPharmacie/$query'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Pharmacie> pharmacies = data
            .map((json) => Pharmacie.fromJson(json))
            .toList(); // Désérialisation en liste de Pharmacie
        return pharmacies;
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (error) {
      throw Exception('Failed to connect to the API: $error');
    }
  }
   Future<InfoPharmacie> toutPharmacieDetail(int idPharmacie) async {
    final response = await http.get(Uri.parse('${ApiUrl.baseUrl}pharmacie/toutInfoPharmacie/$idPharmacie'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      return InfoPharmacie.fromJson(data); // Utilisation de PharmacieDetail.fromJson pour désérialiser les données
    } else {
      throw Exception('Erreur de chargement');
    }
  }
}
