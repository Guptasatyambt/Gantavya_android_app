import 'package:flutter/material.dart';
import 'package:gantavya/widegs/PreviousTripList.dart';



class Previous extends StatefulWidget {
  const Previous({super.key});

  @override
  State<Previous> createState() => _PreviousState();
}

class _PreviousState extends State<Previous> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyList(),
      ],
    );
  }
}


class MyList extends StatelessWidget {
  final List<Map<String, dynamic>> dataList = [
    // ... your data here ...
    {"city": "City 2", "image": "https://happay.com/blog/wp-content/uploads/sites/12/2022/09/Business-Travel-Management-_1_-scaled-1.webp", "FromDate": "19/10/2023","ToDate":"21/11/2023"},
    {"city": "City 2", "image": "https://happay.com/blog/wp-content/uploads/sites/12/2022/09/Business-Travel-Management-_1_-scaled-1.webp", "FromDate": "19/10/2023","ToDate":"21/11/2023"},

    // {"city": "City 1", "image": "assets/images/icon.png", "FromDate": "16/10/23", "ToDate": "16/10/23"},
    // {"city": "City 1", "image": "assets/images/icon.png", "FromDate": "16/10/23", "ToDate": "16/10/23"},
    // {"city": "City 1", "image": "assets/images/icon.png", "FromDate": "16/10/23", "ToDate": "16/10/23"},

  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var data in dataList)
          Column(
            children: [
              PreviousTripList(
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




