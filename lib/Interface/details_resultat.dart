import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Model/detail_pharmacie.dart';
import '../Services/recherche_pharmacie.dart';

class PharmacieDetail extends StatefulWidget {
  final int? id_pharmacie;

  PharmacieDetail(this.id_pharmacie, {Key? key}) : super(key: key);

  @override
  State<PharmacieDetail> createState() => _PharmacieDetailState();
}

class _PharmacieDetailState extends State<PharmacieDetail> {
  RechercheService rechercheService = RechercheService();

  // Créez une variable pour stocker les informations de la pharmacie
  InfoPharmacie? infoPharmacie;
  

  // Créez une fonction pour récupérer les informations de la pharmacie depuis le service
  void fetchPharmacieInfo() async {
    try {
      if (widget.id_pharmacie != null) {
        final response =
            await rechercheService.toutPharmacieDetail(widget.id_pharmacie!);
        // print(response);
        setState(() {
          infoPharmacie = response;
        });
      } else {
        // Gérez le cas où id_pharmacie est null
        print('ID de pharmacie nul');
      }
    } catch (e) {
      // Affichez l'erreur complète pour la déboguer
      print(
          'Erreur lors de la récupération des informations de la pharmacie: $e');
    }
  }
  

  @override
  void initState() {
    super.initState();
    // Appelez la fonction pour récupérer les informations de la pharmacie lorsque le widget est initialisé
    fetchPharmacieInfo();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Information'),
          elevation: 0,
          backgroundColor: Color(0xFF3C9172),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    color: Color(0xFF3C9172),
                    width: h,
                    height: h / 4,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage("assets/avatar1.png"),
                        ),
                        Text("${infoPharmacie!.nom}",
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            )),
                        Text('${infoPharmacie!.numero}',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -20,
                    left: 10,
                    right: 10,
                    child: Container(
                      width: h,
                      height: h * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey, // Couleur de l'ombre
                            offset: Offset(0,
                                1), // Décalage horizontal et vertical de l'ombre
                            blurRadius: 5.0, // Flou de l'ombre
                            spreadRadius: 0.0, // Étalement de l'ombre
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_pharmacy_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              'Information de la pharmacie',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey, // Couleur de l'ombre
                        offset: Offset(
                            0, 1), // Décalage horizontal et vertical de l'ombre
                        blurRadius: 5.0, // Flou de l'ombre
                        spreadRadius: 0.0, // Étalement de l'ombre
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          Text('Adresse'),
                        ],
                      ),
                      Row(
                        children: [
                          Text("${infoPharmacie!.latitude}",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              )),
                          Icon(Icons.business),
                        ],
                      ),
                      Row(
                        children: [
                          Text("${infoPharmacie!.longitude}",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              )),
                          Icon(Icons.call),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey, // Couleur de l'ombre
                        offset: Offset(
                            0, 1), // Décalage horizontal et vertical de l'ombre
                        blurRadius: 5.0, // Flou de l'ombre
                        spreadRadius: 0.0, // Étalement de l'ombre
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          Text('Assurances Disponibles'),
                        ],
                      ),
                      Wrap(
                        alignment: WrapAlignment
                            .start, // Align chips to the start of each row
                        spacing: 4.0, // Horizontal spacing between chips
                        runSpacing:
                            4.0, // Vertical spacing between rows of chips
                        children: infoPharmacie!.assurances.map((assurance) {
                          return Chip(
                            label: Text(
                              assurance.libelle,
                              style: TextStyle(fontSize: 8),
                            ),
                            backgroundColor: Colors.blue[50],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ]));
  }
}
