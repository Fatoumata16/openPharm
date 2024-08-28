import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/assurance.dart';
import '../Model/recherche_pharmacie.dart';
import '../utils/env.dart';

Future<List<RechechePharmacie>> sendLocation(
  double latitude,
  double longitude,
  BuildContext context,
) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  List<RechechePharmacie> searchResults = []; // Initialize an empty list

  // Vérifiez si le token existe dans les préférences partagées
  if (token != null && token.isNotEmpty) {
    final url = Uri.parse('${ApiUrl.baseUrl}rechercheUser/routerechercheUser/');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Ajoutez le token aux en-têtes
    };
    final body = jsonEncode({'latitude': latitude, 'longitude': longitude});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      // Assurez-vous que 'data' est bien une 'Map<String, dynamic>' et a une clé "pharmacies" contenant une liste d'objets
      if (data is Map<String, dynamic> && data['pharmacies'] is List) {
        for (var result in data['pharmacies']) {
          // Traitement des assurances
          List<Assurance> assurances = [];
          if (result['assurances'] is List) {
            for (var assuranceData in result['assurances']) {
              assurances.add(Assurance.fromJson(assuranceData));
            }
          }

          searchResults.add(
            RechechePharmacie.fromJson(result)..assurances = assurances,
          );
        }

        return searchResults; // Return the populated list of search results
      } else {
        // La réponse JSON n'est pas au format attendu (objet contenant la clé "pharmacies" avec une liste d'objets)
        print('Format JSON incorrect : ${data.runtimeType}');
      }
    } else {
      // Gérer les autres cas de statut de réponse
      print('Erreur lors de la requête POST: ${response.statusCode}');
    }
  }

  return searchResults; // Return an empty list if token is null or response code is not 200
}
