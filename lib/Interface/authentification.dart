import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:open_pharm/Interface/tabsss.dart";

import "../Services/authentification_service.dart";
import "inscrip.dart";

class AutentificationPage extends StatefulWidget {
  const AutentificationPage({Key? key}) : super(key: key);

  @override
  State<AutentificationPage> createState() => _AutentificationPageState();
}

class _AutentificationPageState extends State<AutentificationPage> {
  @override
  bool _showPassword = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController telController = TextEditingController();
  AuthController authController = AuthController();

  void loginController() async {
    Map<String, dynamic> result = await authController.loginUser(
      telController,
      passwordController,
    );

    if (result['success']) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(result['message']),
      //     backgroundColor: Colors.green,
      //     behavior: SnackBarBehavior.floating,
      //   ),
      // );

      // Effectuez la redirection ici
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TabsPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

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
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Container(
              // height: MediaQuery.of(context).size.height * 0.14,
              // width: MediaQuery.of(context).size.width * 0.8,
              // color: Colors.black,
              child: Text(
                "Connexion",
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
              height: MediaQuery.of(context).size.height * 0.08,
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
                      Text('Saisissez vos informations',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                          //  color: Colors.white,
                            fontWeight: FontWeight.w400,
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
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
                                    controller:
                                        telController, //controlleur pour recuperer le numero de telephone
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Numero de telephone',
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
                                    .password), // Remplacez "my_icon" par l'icône que vous voulez utiliser
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextFormField(
                                    //controlleur pour recuperer le mots de passe
                                    controller: passwordController,
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

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
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
                                  loginController();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Connexion",
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
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Text(
                        "Vous n’avez pas de compte ?",
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
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
                                              const InscriPage()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Créer un compte",
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
