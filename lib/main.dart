import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Interface/debut.dart';
import 'Interface/details_resultat.dart';
import 'Interface/inscrip.dart';
import 'Interface/page_principale.dart';
import 'Interface/bottom_tabs.dart';
import 'Interface/tabsss.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OpenPharm Mobile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: _checkToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Afficher un écran de chargement ou une animation pendant la vérification du token
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            // Si le token est présent, rediriger vers une page spécifique
            if (snapshot.data == true) {
              return TabsPage(); // Remplacez SpecificPage() par la page de votre choix
            } else {
              return Debut(); // Page par défaut
            }
          }
        },
      ),
    );
  }

// Vérifier la présence du token dans le local storage
  Future<bool> _checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(
        'token'); // Remplacez 'token' par la clé utilisée pour sauvegarder le token
    return token != null && token.isNotEmpty;
  }
}