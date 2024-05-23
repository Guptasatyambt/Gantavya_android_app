import 'package:flutter/material.dart';

import 'package:gantavya/widegs/TripList.dart';

class Upcoming extends StatefulWidget {
  const Upcoming({super.key});

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
       MyList(),
      ],
    );
  }
}


class MyList extends StatelessWidget {
  final List<Map<String, dynamic>> dataList = [
    // ... your data here ...
    {"city": "City 2", "image": "https://happay.com/blog/wp-content/uploads/sites/12/2022/09/Business-Travel-Management-_1_-scaled-1.webp", "FromDate": "16/10/23","ToDate":"24/11/2023"},
     // {"city": "City 1", "image": "assets/images/icon.png"},
    // {"city": "City 1", "image": "assets/images/icon.png", "FromDate": "16/10/23", "ToDate": "16/10/23"},
    // {"city": "City 1", "image": "assets/images/icon.png", "FromDate": "16/10/23", "ToDate": "16/10/23"},
    // {"city": "City 1", "image": "assets/images/icon.png", "FromDate": "16/10/23", "ToDate": "16/10/23"},

  ];

   MyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var data in dataList)
          Column(
            children: [
              TripList(
                city: data["city"] ?? "",
                image: data["image"] ?? "",
                fromDate: data["FromDate"] ?? "",
                 toDate: data["ToDate"] ?? "",
              ),
              const Divider(height: 2, thickness: 1,color: Colors.white38,),
            ],
          ),
      ],
    );
  }
}




