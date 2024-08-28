import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Interface/authentification.dart';
import '../Interface/page_principale.dart';
import '../Interface/tabsss.dart';
import '../Interface/bottom_tabs.dart';
import '../Model/client.dart';
import '../utils/env.dart';

class AuthController {
  // static const url = 'http://localhost:3000/client/connecter';
  // static const urli = 'http://localhost:3000/client/ajouter';
  // static const url = 'http://16.170.232.233:3000/client/connecter';
  // static const urli = 'http://16.170.232.233:3000/client/ajouter';

  TextEditingController telController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomwordController = TextEditingController();
  TextEditingController sexeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<Map<String, dynamic>> loginUser(
    // BuildContext context,
    TextEditingController telController,
    TextEditingController passwordController,
  ) async {
    final String tel = telController.text;
    final String password = passwordController.text;

    // print(tel + ' ' + password);
    String url = '${ApiUrl.baseUrl}client/connecter';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          "tel": tel,
          "password": password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is Map && data.containsKey('token')) {
          final String token = data['token'];

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);

          return {'success': true, 'message': 'Connexion réussie'};
        } else {
          return {
            'success': false,
            'message': 'Mauvaises informations d\'identification'
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Erreur lors de la connexion: ${response.body}'
        };
      }
    } catch (error) {
      print(error);
      return {'success': false, 'message': 'Erreur inattendue : $error'};
    }
  }

  Future<bool> inscrireUtilisateur(
    Map<String, dynamic> utilisateurData,
  ) async {
    try {
      String url = '${ApiUrl.baseUrl}client/ajouter';
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(utilisateurData),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<Utilisateur> trouverClientParId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String url =
        '${ApiUrl.baseUrl}client/infoClient'; // Remplacez l'URL par celle de votre API

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Analysez les données JSON renvoyées par l'API et créez une liste d'utilisateurs à partir de celles-ci
        Map<String, dynamic> jsonData = json.decode(response.body);
        Utilisateur utilisateur = Utilisateur.fromJson(
            jsonData); // Assuming a single user is returned; update the fromJson function accordingly if needed
        return utilisateur;
      } else {
        // Gérez les autres cas de réponse de l'API si nécessaire
        throw Exception("Échec de la récupération des informations du client.");
      }
    } catch (error) {
      // Gérez les erreurs qui peuvent survenir lors de la communication avec l'API
      throw Exception("$error");
    }
  }
  //Modification

  Future<bool> modifierUtilisateur({
    required Utilisateur utilisateur,
    //required int? id_pharmacie,
  }) async {
    try {
      // Récupérer le token depuis SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      // Créer une URL pour l'API de modification de la pharmacie avec l'ID de la pharmacie
      String url = '${ApiUrl.baseUrl}client/modifier';

      // Convertir le modèle Pharmacie en Map (sans le champ de mot de passe)
      Map<String, dynamic> utilisateurMap = utilisateur.toJson();
      utilisateurMap.remove('password'); // Exclure le champ de mot de passe
      utilisateurMap.remove('sexe');

      // Créer les headers de la requête avec le token d'authentification
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      // Convertir le Map en JSON
      String utilisateurJson = jsonEncode(utilisateurMap);

      // Envoyer la requête PUT à l'API et attendre la réponse
      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: utilisateurJson,
      );

      // Vérifier le code de statut de la réponse
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  //Fin modification

  Future<void> deconnexion(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Efface toutes les préférences partagées

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AutentificationPage()),
    );
  }
}
