import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_pharm/Interface/slider_sreens.dart';


class Debut extends StatelessWidget {
  const Debut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF3C9172),
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height * 0.01,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Image.asset(
              "assets/deb.jpg",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 40,
            ),
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
            //     const SizedBox(width: 7),
            //     Container(
            //       width: 14,
            //       height: 14,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: Color(0xB2C4C4C4),
            //       ),
            //     ),
            //     const SizedBox(width: 7),
            //     Container(
            //       width: 14,
            //       height: 14,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: Color(0xB2C4C4C4),
            //       ),
            //     ),
            //     const SizedBox(width: 7),
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
            SizedBox(
              height: 30,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Trouvez les ',
                    style: TextStyle(
                      color: Color(0xFF3F3D56),
                      fontSize: 23,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'Pharmacies',
                    style: TextStyle(
                      color: Color(0xFF3F3D56),
                      fontSize: 23,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: ' de \n garde les plus proche de vous',
                    style: TextStyle(
                      color: Color(0xFF3F3D56),
                      fontSize: 23,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      color: Color(0xFF3C9172),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SliderScreen()));
                        //  builder: (context) => const Essaiie()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Commencer",
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
            )
          ],
        )),
      ),
    );
  }
}
