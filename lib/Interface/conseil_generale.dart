import 'package:flutter/material.dart';

import '../Model/Conseils.dart';
import '../Services/conseils_service.dart';

class Conseil {
  final String image;
  final String description;

  Conseil(this.image, this.description);
}

class ConseilsGeneralepage extends StatefulWidget {
  @override
  _ConseilsGeneralepageState createState() => _ConseilsGeneralepageState();
}

class _ConseilsGeneralepageState extends State<ConseilsGeneralepage> {
  final List<Conseil> conseils = [
    Conseil('assets/doctormuso.png', 'Conseil 1 : Description du conseil 1.'),
    Conseil('assets/doctormuso.png', 'Conseil 2 : Description du conseil 2.'),
    // Ajoutez autant de conseils que nécessaire
  ];

  void initState() {
    super.initState();
    fetchconseilGenerale();
  }

  Future<void> fetchconseilGenerale() async {
    try {
      List<Conseils> conseils = await conseilGenerale();
      // Faites quelque chose avec la liste de conseils récupérée depuis l'API
      print(conseils);
    } catch (e) {
      // Gérer les erreurs ici, par exemple, afficher un message à l'utilisateur
      print('Erreur : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conseils Generl'),
      ),
      body: ListView.builder(
        itemCount: conseils.length,
        itemBuilder: (context, index) {
          return ConseilCard(conseil: conseils[index]);
        },
      ),
    );
  }
}

class ConseilCard extends StatelessWidget {
  final Conseil conseil;

  ConseilCard({required this.conseil});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Image.asset(
            conseil.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(conseil.description),
          ),
        ],
      ),
    );
  }
}
