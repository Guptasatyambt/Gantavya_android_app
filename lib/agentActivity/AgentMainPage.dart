import 'package:flutter/material.dart';
import 'package:gantavya/agentActivity/agentBooking.dart';
import 'package:gantavya/agentActivity/agentHome.dart';
import 'package:gantavya/agentActivity/agentProfile.dart';
import 'package:gantavya/agentActivity/calender.dart';
class AgentMainPage extends StatefulWidget {
  const AgentMainPage({super.key});

  @override
  State<AgentMainPage> createState() => _AgentMainPageState();
}

class _AgentMainPageState extends State<AgentMainPage> {
  final List<Widget> pages=[
    const AgentHome(),
    const Calender(),
    const AgentBooking(),
    const AgentProfile(),
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
          BottomNavigationBarItem(icon: Icon(Icons.person_pin_circle),label:"Dates"),
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
