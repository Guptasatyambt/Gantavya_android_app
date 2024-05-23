import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gantavya/Activity/Previous.dart';
import 'package:gantavya/Activity/Upcoming.dart';
import 'package:gantavya/widegs/navigation.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {

  Future<void> fetchData(BuildContext context) async{
      // API endpoint URL
      final String apiUrl = 'http://10.0.2.2:4002/booking/getall';

      try {
        // Making GET request
        final response = await http.get(Uri.parse(apiUrl));
        print(response.statusCode);
        // Decoding response
        if (response.statusCode == 200) {
          // If the server returns a 200 OK response,
          // parse the JSON
          final Map<String, dynamic> responseData = json.decode(response.body);

          // Process the data here if needed
          print(responseData);
        } else {
          // If the server did not return a 200 OK response,
          // throw an exception
          throw Exception('Failed to load data');
        }
      } catch (e) {
        // Error handling
        print('Error: $e');
        throw e;
      }

  }

  int selectedButtonIndex = 1;

  final List<Widget> pages=[
    const Upcoming(),
   const Previous(),

  ];
  @override
  Widget build(BuildContext context) {
    fetchData(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading:IconButton(onPressed: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
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

