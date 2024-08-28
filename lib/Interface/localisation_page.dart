import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Model/recherche_pharmacie.dart';

class Localisationpage extends StatefulWidget {
  final List<RechechePharmacie> searchResults;

  const Localisationpage(this.searchResults, {Key? key}) : super(key: key);

  @override
  State<Localisationpage> createState() =>
      _LocalisationpageState(searchResults);
}

class _LocalisationpageState extends State<Localisationpage> {
  final List<RechechePharmacie> searchResults;

  _LocalisationpageState(this.searchResults);

  void openGoogleMaps(double latitude, double longitude) async {
    String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Impossible d\'ouvrir Google Maps.';
    }
  }

  void OuvrirClavier(String Contact_pharmacie) async {
    final url = 'tel:$Contact_pharmacie';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Localisation des Pharmacies',
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Assurez-vous d'activer les services de localisation",
              style: GoogleFonts.openSans(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final pharm1 = searchResults[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                child: Image.asset(
                                  'assets/Open Pharm icon.png',
                                  width: 150,
                                  height: 120,
                                ),
                              ),
                            ),
                            SizedBox(
                             height: 3,
                            ),
                            Expanded(
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pharm1.nom_pharmacie,
                                    style: GoogleFonts.openSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_sharp,
                                        color: Color(0xFF3C9172),
                                        size: 40,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "Bamako, Lafiabougou",
                                            style: GoogleFonts.openSans(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff858585),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Distance",
                                                style: GoogleFonts.openSans(
                                                  color: Color(0xff858585),
                                                ),
                                              ),
                                              Text(
                                                "${pharm1.distance} KM",
                                                style: GoogleFonts.openSans(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Text(
                                    "Assurance Disponible:",
                                    style: GoogleFonts.openSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Wrap(
                                    alignment: WrapAlignment
                                        .start, // Align chips to the start of each row
                                    spacing:
                                        4.0, // Horizontal spacing between chips
                                    runSpacing:
                                        4.0, // Vertical spacing between rows of chips
                                    children:
                                        pharm1.assurances.map((assurance) {
                                      return Chip(
                                        label: Text(
                                          assurance.libelle,
                                          style: TextStyle(fontSize: 8),
                                        ),
                                        backgroundColor: Colors.blue[50],
                                      );
                                    }).toList(),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          String Contact_pharmacie =
                                              pharm1.Contact_pharmacie;
                                          OuvrirClavier(Contact_pharmacie);
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.21,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Color(0xff3c9172),
                                          ),
                                          child: Row(
                                           mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.call,
                                                  color: Colors.white),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                              Text(
                                                "Contacter",
                                                style: GoogleFonts.openSans(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          double latitude = pharm1.latitude;
                                          double longitude = pharm1.longitude;
                                          openGoogleMaps(latitude, longitude);
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Color(0xff3c9172),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.location_pin,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                "Maps",
                                                style: GoogleFonts.openSans(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   pharm1.nom_pharmacie,
//                                   style: GoogleFonts.openSans(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),

//                             SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//
//                                 Text(
//                                   pharm1.Contact_pharmacie.toString(),
//                                   style: GoogleFonts.openSans(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xff858585),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   "Assurance Disponible:",
//                                   style: GoogleFonts.openSans(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 SizedBox(width: 5),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Wrap(
//                                     children:
//                                         pharm1.assurances.map((assurance) {
//                                       return Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 4.0),
//                                         child: Chip(
//                                           label: Text(
//                                             assurance.libelle,
//                                             style: TextStyle(fontSize: 16),
//                                           ),
//                                           backgroundColor: Colors.blue[50],
//                                         ),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
