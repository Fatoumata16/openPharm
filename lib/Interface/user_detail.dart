import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Model/client.dart';
import '../Services/authentification_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthController authController = AuthController();
  Utilisateur? utilisateur;

  String nomUtilisateur = "";
  String prenomUtilisateur = "";
  int telephoneUtilisateur = 0;
  String sexeUtilisateur = "";

  Future<void> _showDeconnexion(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deconnexion'),
          content: Text('Etes vous sure de vouloir vous deconnecter ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer le dialogue
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                authController
                    .deconnexion(context); // Appelez la fonction de déconnexion
                // Ajoutez ici la logique à exécuter en cas de confirmation
                Navigator.of(context)
                    .pop(); // Fermer le dialogue après l'action
              },
              child: Text('Deconnexion'),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchUserData() async {
    try {
      Utilisateur utilisateur = await authController.trouverClientParId();
      // Set the values of nomUtilisateur and prenomUtilisateur
      setState(() {
        nomUtilisateur = utilisateur.nom;
        prenomUtilisateur = utilisateur.prenom;
        telephoneUtilisateur = utilisateur.tel;
        sexeUtilisateur = utilisateur.sexe;

        print(nomUtilisateur);

        authController.nomController.text = nomUtilisateur.toString();
        authController.prenomwordController.text = prenomUtilisateur.toString();
        authController.telController.text = telephoneUtilisateur.toString();
        // authController.sexeController.text = sexeUtilisateur.toString();
      });
    } catch (error) {
      // Handle errors here
      print(
          "Erreur lors de la récupération des données de l'utilisateur: $error");
    }
  }
  //debut modifier

  Utilisateur collecterValeursModifiees() {
    String nom = authController.nomController.text;
    String prenom = authController.prenomwordController.text;
    int tel = int.parse(authController.telController.text);
    String sexe = authController.sexeController.text;

    // Créez un objet Pharmacie spécifiquement pour la modification
    Utilisateur utilisateur = Utilisateur.forModification(
        nom: nom, prenom: prenom, tel: tel, sexe: sexe);

    return utilisateur;
  }

  void onSubmitButtonPressed() async {
    // Collectez les nouvelles valeurs des champs d'entrée
    Utilisateur utilisateurModifier = collecterValeursModifiees();

    // Appelez la fonction pour effectuer la modification
    bool modificationreussie = await authController.modifierUtilisateur(
      utilisateur: utilisateurModifier,
      //id_pharmacie: pharmacieModifiee.id_pharmacie,
      // Assurez-vous d'avoir défini le context approprié avant d'appeler cette fonction.
    );

    if (modificationreussie) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("utilisateur modifiée avec succès"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur lors de la modification de la utilisateur"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    fetchUserData();
  }

//
  void showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Modifier mon profil',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffD9D9D9),
                      border: Border.all(color: const Color(0xff858585)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(Icons.account_circle),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: authController.prenomwordController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Prénom',
                                hintStyle: GoogleFonts.openSans(
                                  color: const Color(0xff858585),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffD9D9D9),
                      border: Border.all(color: const Color(0xff858585)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(Icons.account_circle),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: authController.nomController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Nom',
                                hintStyle: GoogleFonts.openSans(
                                  color: const Color(0xff858585),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffD9D9D9),
                      border: Border.all(color: const Color(0xff858585)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(Icons.account_circle),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: authController.telController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Numéro',
                                hintStyle: GoogleFonts.openSans(
                                  color: const Color(0xff858585),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Ajoutez d'autres champs de saisie ici si nécessaire
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Fermer la boîte de dialogue sans utiliser les données saisies
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // Couleur de fond du bouton
                        onPrimary: Colors.white, // Couleur du texte du bouton
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Bordure du bouton
                        ),
                      ),
                      child: Text('Annuler', style: TextStyle(fontSize: 16.0)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        onSubmitButtonPressed();
                        Navigator.of(context).pop();
                        // Utilisez ces valeurs comme vous le souhaitez
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Couleur de fond du bouton
                        onPrimary: Colors.white, // Couleur du texte du bouton
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Bordure du bouton
                        ),
                      ),
                      child: Text('Valider', style: TextStyle(fontSize: 16.0)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  //fin modifier

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3C9172),
        elevation: 0,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  alignment: Alignment.center, // Centrer l'icône
                  icon: Icon(
                    Icons.power_settings_new_rounded,
                    color: Colors.red,
                    size: 35,
                  ),
                  onPressed: () async {
                    _showDeconnexion(context);
                    // Vos actions ici
                  },
                ),
              )),
        ],
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
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                  child: Image.asset(
                    "assets/jprofile.jpg",
                    fit: BoxFit.cover,
                    height: h / 3,
                    width: MediaQuery.of(context).size.width * 1,
                  ),
                ),
              ),
              const Positioned(
                bottom: -40,
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/img_avatar.png'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: h * 0.07,
          ),
          Center(
            child: Column(
              children: [
                Text(
                  prenomUtilisateur + ' ' + nomUtilisateur,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${telephoneUtilisateur}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              showMyDialog(context);
            },
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.edit_document),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    Text("Modifier le profil")
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
