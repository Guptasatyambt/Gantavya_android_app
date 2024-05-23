import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gantavya/widegs/List.dart';

class AgentHome extends StatefulWidget {
  const AgentHome({super.key});

  @override
  State<AgentHome> createState() => _AgentHomeState();
}

class _AgentHomeState extends State<AgentHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading:Image.asset("assets/images/icon.png"),
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
      body:Center(
        child: SingleChildScrollView(
          child: Column(
              children:[
                SizedBox(
                  height:250,
                  child: GestureDetector(
                    onTap: () {
                      // Handle the onTap action here
                      print('Crousel tapped!');
                      // You can navigate to a new screen, show a dialog, etc.
                    },
                    child: CarouselSlider(
                      items: [
                        // Add your carousel items here
                        Image.asset("assets/images/icon2.png"),
                        Image.network('https://happay.com/blog/wp-content/uploads/sites/12/2022/09/Business-Travel-Management-_1_-scaled-1.webp'),
                        Image.network('https://happay.com/blog/wp-content/uploads/sites/12/2022/09/Business-Travel-Management-_1_-scaled-1.webp'),
                      ],
                      options: CarouselOptions(
                        height: 250.0, // Adjust the height of the carousel
                        aspectRatio: 16/9, // Adjust the aspect ratio of the carousel items
                        viewportFraction: .98, // Adjust the width of the carousel items
                        initialPage: 0, // Set the initial page
                        enableInfiniteScroll: true, // Allow infinite scrolling
                        reverse: false, // Reverse the order of items
                        autoPlay: true, // Enable auto-play
                        autoPlayInterval: const Duration(seconds: 3), // Set auto-play interval
                        autoPlayAnimationDuration: const Duration(milliseconds: 800), // Set auto-play animation duration
                        autoPlayCurve: Curves.fastOutSlowIn, // Set auto-play animation curve
                        enlargeCenterPage: true, // Enlarge the center item
                        onPageChanged: (index, reason) {
                          // Callback when the page changes
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                const Text("Top Rated Agent",style: TextStyle(color: Colors.white70) ,),
                const SizedBox(height: 10,),
                Column(
                  children: [
                    MyList(),
                  ],
                ),
                const SizedBox(height: 20,),


                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(width: MediaQuery.of(context).size.width * .3,),
                    Icon(Icons.copyright_outlined,color: Colors.white70,),
                    Text(" 2024",style: TextStyle(color: Colors.white70),),

                  ],
                ),




              ]
          ),
        ),
      ),

    );
  }
}


class MyList extends StatelessWidget {
  final List<Map<String, String>> dataList = [
    {"name": "Item 1", "city": "City 1", "rating": "4"},
    {"name": "Item 2", "city": "City 2", "rating": "3"},
    {"name": "Item 3", "city": "City 3", "rating": "5"},
    {"name": "Item 1", "city": "City 1", "rating": "4"},
    {"name": "Item 2", "city": "City 2", "rating": "3"},
    {"name": "Item 3", "city": "City 3", "rating": "5"},
    // Add more items as needed
  ];

  MyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var data in dataList)
          Column(
            children: [
              MyListItem(
                name: data["name"] ?? "",
                city: data["city"] ?? "",
                rating: data["rating"] ?? "",
              ),
              const Divider(height: 2,thickness: 1,color: Colors.white38,),
            ],
          ),

      ],
    );
  }
}

