import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/stylee.dart';
import '../widget/textbtn.dart';
import 'authentification.dart';

class SliderScreen extends StatefulWidget {
  static const String id = 'SliderScreen';

  const SliderScreen({Key? key}) : super(key: key);

  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  int _current = 0;

  final CarouselController _controller = CarouselController();

  List<Item> imgList = <Item>[
    const Item('assets/2im.gif', 'LOCALISATION !',
        'OpenPharm vous offre la possibilité de repérer les pharmacies de garde à proximité, dans un rayon de 40 km.'),
    const Item('assets/Insurance.gif', 'ASSURANCE',
        'Avec OpenPharm, vous avez la capacité de découvrir aisément les pharmacies partenaires des différentes assurances maladie disponibles.'),
    const Item('assets/slider1.gif', 'CONSEILS SANTÉ',
        'OphenPharm vous donner droit a des conseils sur la santé'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _itemCarausl(),
        ],
      ),
    );
  }

  Widget _itemCarausl() {
    return Builder(
      builder: (context) {
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * .8,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
                autoPlay: true,
              ),
              items: imgList
                  .map((e) => Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // logoImg(),
                          Image.asset(
                            e.img,
                            fit: BoxFit.fitHeight,
                            height: MediaQuery.of(context).size.width * .8,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: centerHeading(e.detail),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: centerText(e.text),
                          ),
                        ],
                      )))
                  .toList(),
              carouselController: _controller,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : appColor)
                            .withOpacity(_current == entry.key ? 0.8 : 0.4)),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 60,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AutentificationPage()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
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
            ),
          ],
        );
      },
    );
  }

  logoImg() {
    return Image.asset(
      'assets/images/job.png',
      width: 120,
      height: 100,
    );
  }
}

class Item {
  const Item(
    this.img,
    this.detail,
    this.text,
  );
  final String img;
  final String detail;
  final String text;
}
