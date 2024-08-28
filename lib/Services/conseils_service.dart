import 'package:flutter/material.dart';
import '../Model/Conseils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/env.dart';

// Fonction pour récupérer les conseils par catégorie avec le token
Future<List<Conseils>> conseilReproductive() async {
  String url = '${ApiUrl.baseUrl}categorie/conseilparcategorie';

  // Récupérer le token depuis les SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json', // Spécifier le type de contenu en JSON
      },
      body: json.encode({'nom': "sante reproductive"}), // Convertir le corps en JSON
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData.map((json) => Conseils.fromJson(json)).toList();
    } else {
      // Gérer les cas d'erreur, par exemple :
      throw Exception('Échec de la requête : ${response}');
    }
  } catch (e) {
    // Gérer les erreurs liées à la connexion, etc.
    throw Exception('Erreur lors de la communication avec l\'API : $e');
  }
}

// Fonction pour récupérer les conseils par catégorie avec le token
Future<List<Conseils>> conseilGenerale() async {
  String url = '${ApiUrl.baseUrl}categorie/conseilparcategorie';

  // Récupérer le token depuis les SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json', // Spécifier le type de contenu en JSON
      },
      body: json.encode({'nom': "conseil generale"}), // Convertir le corps en JSON
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData.map((json) => Conseils.fromJson(json)).toList();
    } else {
      // Gérer les cas d'erreur, par exemple :
      throw Exception('Échec de la requête : ${response.statusCode}');
    }
  } catch (e) {
    // Gérer les erreurs liées à la connexion, etc.
    throw Exception('Erreur lors de la communication avec l\'API : $e');
  }
}

