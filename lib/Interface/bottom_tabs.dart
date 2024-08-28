import 'package:flutter/material.dart';
import 'package:open_pharm/Interface/page_principale.dart';

// import 'profile.dart';
import 'conseil.dart';
import 'localisation_page.dart';

class BottomTabs extends StatefulWidget {
  const BottomTabs({Key? key}) : super(key: key);

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int currentPage = 0;
  final screens = [
    MapsPage(),
    Conseilpage(),
   // ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: screens,
      ),
      bottomNavigationBar:SafeArea(

              child: Container(
              //  padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.8)
                ),
                child: BottomNavigationBar(
          //  backgroundColor: Colors.white,
            elevation: 0,
            currentIndex: currentPage,
            onTap: (index) {
                setState(() {
                  currentPage = index;
                });
            },
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey.shade700,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            selectedIconTheme: IconThemeData(size: 20),
            unselectedIconTheme: IconThemeData(size: 22),
            items: [
                BottomNavigationBarItem(
                  icon: currentPage == 0
                      ? Container(
                        width: 80,
                        height: 50,
                          decoration: BoxDecoration(
                            //shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFF3C9172),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Icon(
                              Icons.home_outlined,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.home_outlined,
                          color: Colors.grey.shade700,
                        ),
                  label: 'home',
                ),

                BottomNavigationBarItem(
                  icon: currentPage == 1
                      ? Container(
                       width: 80,
                        height: 50,
                          decoration: BoxDecoration(
                            //shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFF3C9172),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Icon(Icons.assignment_outlined,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Icon(Icons.assignment_outlined,
                          color: Colors.grey.shade700,
                        ),
                  label: 'advice',
                ),
            ],
          ),
              ),
      ),
    );
  }
}
