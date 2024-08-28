// import 'package:flutter/material.dart';

// import '../utils/constante.dart';


// class CatPage extends StatefulWidget {
//   const CatPage({Key? key}) : super(key: key);

//   @override
//   State<CatPage> createState() => _CategoriesState();
// }

// class _CategoriesState extends State<CatPage> {
//   List<String> categories = [
//     "Tout",
//     "Sante Générale",
//     "Réproductive",
//   ];
//   int selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
//       child: SizedBox(
//         height: 25,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: categories.length,
//           itemBuilder: (context, index) => buildCategorie(index),
//         ),
//       ),
//     );
//   }

//   Widget buildCategorie(int index) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedIndex = index;
//         });
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               categories[index],
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: selectedIndex == index ? KTextColor : KTextLightcolor,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: kDefaultPaddin / 4),
//               height: 2,
//               width: 30,
//               color: selectedIndex == index ? Colors.black : Colors.transparent,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
