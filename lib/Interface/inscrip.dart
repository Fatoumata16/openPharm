import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:open_pharm/Interface/authentification.dart";
import "../Services/authentification_service.dart";

class InscriPage extends StatefulWidget {
  const InscriPage({Key? key}) : super(key: key);

  @override
  State<InscriPage> createState() => _InscriPageState();
}

class _InscriPageState extends State<InscriPage> {
  AuthController authController = AuthController();
  bool _showPassword = false;
  void _handleInscription() async {
    // Préparez les données de l'utilisateur pour l'inscription
    Map<String, dynamic> userData = {
      "tel": authController.telController.text,
      "nom": authController.nomController.text,
      "prenom": authController.prenomwordController.text,
      "sexe": authController.sexeController.text,
      "password": authController.passwordController.text,
    };

    // Appelez la méthode d'inscription de AuthController
    bool inscripReussi = await authController.inscrireUtilisateur(userData);

    if (inscripReussi) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Inscription validée avec succès."),
          backgroundColor:
              Colors.green, // Couleur de fond pour la validation réussie
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Redirigez vers la page de connexion après l'inscription réussie
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AutentificationPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur lors du proccessus"),
          backgroundColor:
              Colors.red, // Couleur de fond pour la validation réussie
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    // Affichez le SnackBar de validation ou d'erreur après l'inscription réussie
  }

  @override
  Widget build(BuildContext context) {
    hauteur:
    MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(
              'assets/Inscription2.jpg'), // Remplacez par le chemin de votre image
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              // height: MediaQuery.of(context).size.height * 0.14,
              // width: MediaQuery.of(context).size.width * 0.8,
              // color: Colors.black,
              child: Text(
                "Création de compte",
                style: GoogleFonts.poppins(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      // Text("Etapes"),

                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.01,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       width: 14,
                      //       height: 14,
                      //       decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: Color(0xFF3C9172),
                      //       ),
                      //     ),
                      //     const SizedBox(width: 10),
                      //     Container(
                      //       width: 14,
                      //       height: 14,
                      //       decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: Color(0xB2C4C4C4),
                      //       ),
                      //     ),
                      //     const SizedBox(width: 10),
                      //     Container(
                      //       width: 14,
                      //       height: 14,
                      //       decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: Color(0xB2C4C4C4),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.08,
                      // ),
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
                                  child: Icon(Icons
                                      .account_circle) // Remplacez "my_icon" par l'icône que vous voulez utiliser
                                  ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextFormField(
                                    controller:
                                        authController.prenomwordController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Prenom',
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
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),

                      // deuxieme input

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
                                child: Icon(Icons
                                    .account_circle), // Remplacez "my_icon" par l'icône que vous voulez utiliser
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
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
                        height: MediaQuery.of(context).size.height * 0.03,
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
                                child: Icon(Icons
                                    .call), // Remplacez "my_icon" par l'icône que vous voulez utiliser
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextFormField(
                                    controller: authController.telController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'N° de téléphone',
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
                        height: MediaQuery.of(context).size.height * 0.03,
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
                                child: Icon(Icons
                                    .password), // Remplacez "my_icon" par l'icône que vous voulez utiliser
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextFormField(
                                    //controlleur pour recuperer le mots de passe
                                    controller: authController.passwordController,
                                    obscureText:
                                        !_showPassword, // Utilisez la variable d'état ici

                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Entrez votre mot de passe',
                                      hintStyle: GoogleFonts.openSans(
                                        color: const Color(0xff858585),
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _showPassword =
                                                !_showPassword; // Inversez l'état _showPassword
                                          });
                                        },
                                        child: Icon(
                                          _showPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Color(0xFF3C9172),
                                        ),
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
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),

                      // troisieme input

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
                                child: Icon(Icons
                                    .transgender), // Remplacez "my_icon" par l'icône que vous voulez utiliser
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButtonFormField<String>(
                                    value: authController
                                            .sexeController.text.isNotEmpty
                                        ? authController.sexeController.text
                                        : null, // Sélection par défaut (aucun)
                                    onChanged: (newValue) {
                                      authController.sexeController.text =
                                          newValue!;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Sélectionnez le sexe',
                                      hintStyle: GoogleFonts.openSans(
                                        color: const Color(0xff858585),
                                      ),
                                    ),
                                    items: <String>['Masculin', 'Féminin']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.055,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: MaterialButton(
                                color: Color(0xFF3C9172),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  _handleInscription();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Valider",
                                    // style: TextStyle(color: Colors.white,fontSize: 22),
                                    style: GoogleFonts.openSans(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Text(
                        "Vous avez déjà un compte ?",
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: MaterialButton(
                                // color: Color(0xFF3C9172),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(color: Colors.black)),

                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AutentificationPage()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Se connecter",
                                    // style: TextStyle(color: Colors.white,fontSize: 22),
                                    style: GoogleFonts.openSans(
                                      fontSize: 22,
                                      // color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ]),
    ));
  }
}
