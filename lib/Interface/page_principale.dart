import "package:flutter/material.dart";
import "package:flutter_animated_button/flutter_animated_button.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:geolocator/geolocator.dart";
import "package:google_fonts/google_fonts.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import 'package:flutter/services.dart' show rootBundle;
import "package:open_pharm/Interface/user_detail.dart";
import "package:snapping_sheet/snapping_sheet.dart";
import "package:url_launcher/url_launcher.dart";

import "../Model/client.dart";
import '../Model/recherche_pharmacie.dart';

import '../Model/pharmacie.dart';
import '../Services/localisation_service.dart';
import "../Services/authentification_service.dart";
import "../Services/recherche_pharmacie.dart";
import "details_resultat.dart";
import 'localisation_page.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  String? _mapStyle;
  Marker _userMarker = Marker(markerId: MarkerId("default_marker"));

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(12.648448, -7.992115),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    getLocation();
    fetchUserData();
  }

  GoogleMapController? myMapController;

  bool isLoading = false;
  List<RechechePharmacie> searchResults = [];
  AuthController authController = AuthController();

  Position? _currentPosition;
  double? latitude;
  double? longitude;

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérifier si les services de localisation sont activés
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Services de localisation désactivés, afficher un message d'erreur ou prendre une action appropriée

      return print('Services de localisation désactivés');
    }

    // Vérifier les permissions de localisation
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Permissions de localisation non accordées, demander les permissions
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions de localisation toujours non accordées, afficher un message d'erreur ou prendre une action appropriée

        return print('Permissions de localisation non accordées');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Les permissions de localisation ont été refusées de façon permanente, afficher un message d'erreur ou prendre une action appropriée

      return print('Permissions de localisation refusées de façon permanente');
      ;
    }

    // Obtenir la position actuelle
    _currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    latitude = _currentPosition?.latitude;
    longitude = _currentPosition?.longitude;

    // Afficher la latitude et la longitude
    print('Latitude: ${_currentPosition?.latitude}');
    print('Longitude: ${_currentPosition?.longitude}');

    setState(() {
      _kGooglePlex = CameraPosition(
        target: LatLng(latitude ?? 12.648448, longitude ?? -7.992115),
        zoom: 14.4746,
      );

      // Update the user's marker
      _userMarker = Marker(
        markerId: MarkerId("user_marker"),
        position: LatLng(latitude ?? 12.648448, longitude ?? -7.992115),
        // You can customize the appearance of the marker by adding other properties like icon, infoWindow, etc.
      );
    });
  }

  Utilisateur? utilisateur;

  String nomUtilisateur = "";
  String prenomUtilisateur = "";
  String telephoneUtilisateur = "";
  String sexeUtilisateur = "";

  Future<void> fetchUserData() async {
    try {
      Utilisateur utilisateur = await authController.trouverClientParId();
      // Set the values of nomUtilisateur and prenomUtilisateur
      setState(() {
        nomUtilisateur = utilisateur.nom;
        prenomUtilisateur = utilisateur.prenom;
      });
    } catch (error) {
      // Handle errors here
      print(
          "Erreur lors de la récupération des données de l'utilisateur: $error");
    }
  }

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

  Future<void> Lancerlocalisation() async {
    await getLocation();
    if (latitude != null && longitude != null) {
      List<RechechePharmacie> fetchedSearchResults =
          await sendLocation(latitude!, longitude!, context);
      setState(() {
        searchResults = fetchedSearchResults;
      });
    }

    _openModalBottomSheet(context);
  }

  void _openModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(),
      context: context,
      builder: (BuildContext context) {
        return makeDismissible(
          child: DraggableScrollableSheet(
            initialChildSize: 0.8,
            minChildSize: 0.3,
            maxChildSize: 1,
            builder: (_, Controller) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    'Resultats de la recherche',
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Cliquez sur une pharmacie pour plus de détails',
                    style: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  //////

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
                                        // border: Border.all(
                                        //   color: Colors.grey,
                                        //   width: 2,
                                        // ),
                                      ),
                                      child: Image.asset(
                                        'assets/Open Pharm icon.png',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Expanded(
                                    child: Column(
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text(
                                        //   pharm1.nom_pharmacie,
                                        //   style: GoogleFonts.openSans(
                                        //     fontSize: 18,
                                        //     fontWeight: FontWeight.w600,
                                        //     color: Colors.black,
                                        //   ),
                                        // ),
                                        RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontStyle: FontStyle
                                                  .italic, // Ajoutez cette ligne pour l'italique
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: pharm1.nom_pharmacie,
                                              ),
                                            ],
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: 3,
                                        // ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.location_on_sharp,
                                              color: Color(0xFF3C9172),
                                              size: 40,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01,
                                            ),
                                            Expanded(
                                              child: Column(
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Bamako, Lafiabougou 📬",
                                                    style: GoogleFonts.openSans(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xff858585),
                                                    ),
                                                  ),
                                                  Row(
                                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                                    // mainAxisAlignment:
                                                    //     MainAxisAlignment
                                                    //         .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Distance :",
                                                        style: GoogleFonts
                                                            .openSans(
                                                          color:
                                                              Color(0xff858585),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                      ),
                                                      Text(
                                                        "${pharm1.distance} KM",
                                                        style: GoogleFonts
                                                            .openSans(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        // SizedBox(
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height *
                                        //       0.01,
                                        // ),
                                        RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontStyle: FontStyle
                                                  .italic, // Ajoutez cette ligne pour l'italique
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: "Assurance Disponible:",
                                              ),
                                            ],
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height *
                                        //       0.01,
                                        // ),
                                        //liste d'assurance

                                        SingleChildScrollView(
                                          scrollDirection: Axis
                                              .horizontal, // Défilement horizontal
                                          child: Wrap(
                                            alignment: WrapAlignment
                                                .start, // Alignement des chips au début de chaque ligne
                                            spacing:
                                                4.0, // Espacement horizontal entre les chips
                                            runSpacing:
                                                4.0, // Espacement vertical entre les lignes de chips
                                            children: pharm1.assurances
                                                .map((assurance) {
                                              return Chip(
                                                label: Text(
                                                  assurance.libelle,
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                                backgroundColor:
                                                    Colors.blue[50],
                                              );
                                            }).toList(),
                                          ),
                                        ),

                                        //liste d'assurance

                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                        //button
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                String Contact_pharmacie =
                                                    pharm1.Contact_pharmacie;
                                                OuvrirClavier(
                                                    Contact_pharmacie);
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.28,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.035,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Color(0xff3c9172),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.call,
                                                        color: Colors.white),
                                                    // SizedBox(
                                                    //   height: 5,
                                                    // ),
                                                    Text(
                                                      "Contacter",
                                                      style:
                                                          GoogleFonts.openSans(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // SizedBox(
                                            //   width: 10,
                                            // ),
                                            GestureDetector(
                                              onTap: () {
                                                double latitude =
                                                    pharm1.latitude;
                                                double longitude =
                                                    pharm1.longitude;
                                                openGoogleMaps(
                                                    latitude, longitude);
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.28,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.035,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Color(0xff3c9172),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.location_pin,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "Maps",
                                                      style:
                                                          GoogleFonts.openSans(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                        //button
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: MediaQuery.of(context).size.height *
                              //       0.01,
                              // ),

                              //     Column(
                              //       children: [

                              //       ],
                              // ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  ////
                ],
              ),
              // Votre contenu modal ici
            ),
          ),
        );
      },
    );
  }

  Widget makeDismissible({required Widget child}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(
            context); // Ferme la feuille modale lorsqu'on clique à l'extérieur
      },
      child: GestureDetector(
        onTap:
            () {}, // Empêche la propagation du clic à travers le contenu modal
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_currentPosition != null)
          ? Stack(
              children: [
                GoogleMap(
                  //  zoomControlsEnabled: true,
                  myLocationButtonEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    myMapController = controller;
                    myMapController!.setMapStyle(_mapStyle);
                    // Déplacer la caméra vers la position actuelle avec le marqueur
                    myMapController!.animateCamera(
                      CameraUpdate.newLatLngZoom(
                        LatLng(latitude ?? 12.648448, longitude ?? -7.992115),
                        14.4746,
                      ),
                    );
                  },
                  initialCameraPosition: _kGooglePlex,
                  markers: Set<Marker>.of([_userMarker]),
                ),
                buildProfileInfo(),
                buildLancerLocalisation(),
              ],
            )
          : Center(
              // Afficher un indicateur de chargement ou une image en attendant
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget buildBottomTabs() {
    return Positioned(child: Container());
  }

  Widget buildProfileInfo() {
    return Positioned(
        top: MediaQuery.of(context).size.height * 0.04,
        left: MediaQuery.of(context).size.width * 0.01,
        right: MediaQuery.of(context).size.width * 0.01,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      showSearch(context: context, delegate: CustomSearch());
                    },
                    child: Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text('Rechercher une pharmacie a proximité',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              //  color: Colors.white,
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.green
                              .shade400, // Remplacez la couleur par celle que vous souhaitez utiliser
                          width:
                              1.0, // Ajustez l'épaisseur de la bordure si nécessaire
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage("assets/img_avatar.png"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildBotomBar() {
    return Positioned(child: Container());
  }

  Widget buildLancerLocalisation() {
    return Positioned(
      right: MediaQuery.of(context).size.height * 0.05,
      bottom: MediaQuery.of(context).size.height * 0.18,
      child: GestureDetector(
        onTap: () async {
          // if (!isLoading) {
          //   setState(() {
          //     isLoading = true;
          //   });

          await getLocation();
          if (latitude != null && longitude != null) {
            await sendLocation(latitude!, longitude!, context);
          }

          //   setState(() {
          //     isLoading = false;
          //   });
          // }
          // _openModalBottomSheet(context);
          Lancerlocalisation();
        },
        child: Container(
          //  height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: Colors.green
                  .shade400, // Remplacez la couleur par celle que vous souhaitez utiliser
              width: 1.0, // Ajustez l'épaisseur de la bordure si nécessaire
            ),
            //borderRadius: BorderRadius.circular(30),
            //color: Color(0xFF3C9172),
            // borderRadius: BorderRadius.circular(300)
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // SpinKitDoubleBounce(
              //   color: Colors.black,
              //   size: 100,
              // ),
              Image.asset(
                'assets/Open Pharm icon.png',
                width: 80,
                height: 80,
              )
              // Icon(
              //   Icons.location_on,
              //   size: 50.0,
              //   //color: Color(0xFF3C9172),
              //   color: Colors.white,
              // ),

              // Positioned(
              //   top: 20,
              //   child: Text(
              //     'Localisation',
              //     style: TextStyle(
              //       fontSize: 24,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearch extends SearchDelegate {
  List<String> allData = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future<List<Pharmacie>> recherche(String query) async {
      final recherche = RechercheService();
      return recherche.rechercheParNom(query);
    }

    return FutureBuilder<List<Pharmacie>>(
      future: recherche(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Text('Aucun résultat trouvé.');
        } else {
          List<Pharmacie> matchQuery = snapshot.data!;
          return ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              var result = matchQuery[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          PharmacieDetail(result.id_pharmacie),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(result.nom),
                  subtitle:
                      Text(result.numero.toString()), // Convertir en String
                ),
              );
            },
          );
        }
      },
    );
  }
}
