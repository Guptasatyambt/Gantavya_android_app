import 'package:flutter/material.dart';
import 'package:gantavya/Activity/home.dart';
import 'package:gantavya/Activity/Sarthi.dart';
import 'package:gantavya/Activity/Booking.dart';
import 'package:gantavya/Activity/Profile.dart';
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> pages=[
    const Home(),
    const Sarthi(),
    const Booking(),
    const Profile(),
  ];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(

        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label:"Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person_pin_circle),label:"Sarthi"),
          BottomNavigationBarItem(icon: Icon(Icons.book_online),label:"Booking"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label:"Profile"),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
