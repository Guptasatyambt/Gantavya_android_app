import 'package:flutter/material.dart';
import 'package:gantavya/agentActivity/AgentMainPage.dart';
import 'package:gantavya/agentActivity/lastTrips.dart';
import 'package:gantavya/agentActivity/nextTrips.dart';

class AgentBooking extends StatefulWidget {
  const AgentBooking({super.key});

  @override
  State<AgentBooking> createState() => _AgentBookingState();
}

class _AgentBookingState extends State<AgentBooking> {
  int selectedButtonIndex = 1;

  final List<Widget> pages=[
    const NextTrips(),
    const LastTrips(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading:IconButton(onPressed: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AgentMainPage()),
          );
        }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search,color: Colors.white,),
            onPressed: () {
              // Add your search functionality here
              print('Search Button hit!');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1.0, color: Colors.white38),
                      right: BorderSide(
                          width: 1.0, color: Colors.white38),
                    ),

                  ),

                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 45,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedButtonIndex = 1;
                        // _selectedIndex=0;
                      });
                    },
                    autofocus: true,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                            (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0), // Optional: border radius
                          );
                        },
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          // If the button is selected, make it blue; otherwise, make it transparent
                          return selectedButtonIndex == 1
                              ? Colors.blue
                              : Colors.transparent;
                        },
                      ),
                    ),

                    child: const Text("Upcoming Trips",style: TextStyle(color: Colors.white70),),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1.0, color: Colors.white38),

                    ),

                  ),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 45,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedButtonIndex = 2;
                        // _selectedIndex=1;
                      });
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                            (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0), // Optional: border radius
                          );
                        },
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          // If the button is selected, make it blue; otherwise, make it transparent
                          return selectedButtonIndex == 2
                              ? Colors.blue
                              : Colors.transparent;
                        },
                      ),
                    ),
                    child: const Text("Pevious Trips",style: TextStyle(color: Colors.white70),),
                  ),
                ),
              ],
            ),
            pages[selectedButtonIndex-1],
          ],
        ),
      ),
    );
  }
}
