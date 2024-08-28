import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constante.dart';
import 'conseil_generale.dart';

class Conseilpage extends StatefulWidget {
  const Conseilpage({Key? key}) : super(key: key);

  @override
  State<Conseilpage> createState() => _ConseilpageState();
}

class _ConseilpageState extends State<Conseilpage> {
  List<String> categories = ["Tout", "Santé", "Ordinateur"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //   appBar: AppBar(
    //   title: TextField(
    //     decoration: InputDecoration(
    //       hintText: "Rechercher...",
    //       icon: Icon(Icons.search),
    //     ),
    //     onChanged: (value) {
    //       // Traitez la recherche en fonction de la valeur saisie (value).
    //       // Vous pouvez mettre à jour une liste de résultats ici.
    //     },
    //   ),
    // ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text('Conseil',style: GoogleFonts.poppins(
                  fontSize: 20,
                  //color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height: 1,
                )),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin,),
                child: SizedBox(
                  height: 25,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPaddin),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                categories[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: selectedIndex == index
                                      ? Colors.black // Utilisez la couleur souhaitée lorsque la catégorie est sélectionnée
                                      : Colors.grey, // Utilisez la couleur souhaitée lorsque la catégorie n'est pas sélectionnée
                                ),
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(top: kDefaultPaddin / 4),
                                height: 2,
                                width: 30,
                                color: selectedIndex == index
                                    ? Colors.black // Utilisez la couleur souhaitée lorsque la catégorie est sélectionnée
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Contenu dynamique en fonction de la catégorie sélectionnée
              if (selectedIndex == 0) ...[
                // Afficher tout le contenu
                 SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConseilsGeneralepage()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'assets/sante1.png', // Replace with your image URL
                          fit: BoxFit.contain,
                          height: MediaQuery.of(context).size.height * 0.25,
                        ),
                        Center(
                          child: Text(
                            'Conseil general sur la sante ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
                // Remplacez ce bloc par le contenu réel que vous souhaitez afficher
              ],
              if (selectedIndex == 1) ...[
                // Afficher le contenu lié à la catégorie "Santé"
                // Remplacez ce bloc par le contenu réel que vous souhaitez afficher
              ],
              if (selectedIndex == 2) ...[
                // Afficher le contenu lié à la catégorie "Ordinateur"
                // Remplacez ce bloc par le contenu réel que vous souhaitez afficher
              ],
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(children: [
//               Text("Conseils",
//                   style: GoogleFonts.openSans(
//                     fontSize: 26,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   )),
//               //////////////
//               //  CatPage(),
//               SizedBox(
//                 height: 40,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ConseilsGeneralepage()),
//                   );
//                 },
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height * 0.3,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Image.asset(
//                         'assets/sante1.png', // Replace with your image URL
//                         fit: BoxFit.contain,
//                         height: MediaQuery.of(context).size.height * 0.25,
//                       ),
//                       Center(
//                         child: Text(
//                           'Conseil general sur la santer ',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ConseilsPage()),
//                   );
//                 },
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height * 0.3,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Image.network(
//                         'https://i0.wp.com/conseilsante.cliniquecmi.com/wp-content/uploads/2022/03/Blessures-et-traitements-conseil-sante.png?fit=1100%2C660&ssl=1', // Replace with your image URL
//                         fit: BoxFit.cover,
//                         height: MediaQuery.of(context).size.height * 0.25,
//                       ),
//                       Center(
//                         child: Text(
//                           'Conseil sur la santer réproductive',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               ///
//               //Text("page 3"),CircularProgressIndicator()
//             ]),
//           ),
