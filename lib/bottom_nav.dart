import 'package:connex/contacts_page.dart';
import 'package:connex/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:connex/favorite_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
   int _currentIndex = 0;

  final List<Widget> Pages =
  [
    ContactsPage(),
    FavoritePage(),
    SettingsPage(),
  ];


void onNavTapped(int index)
{
 setState(() {
   _currentIndex = index;

 });
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: Pages,
      ),



      bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            currentIndex: _currentIndex,
          onTap: onNavTapped,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey.shade700,

          items: const [
              BottomNavigationBarItem(icon: Icon(Icons.person_2_rounded), label: 'Contacts'),
              BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
          ],
          type: BottomNavigationBarType.fixed,
      ),


    );
  }
}
