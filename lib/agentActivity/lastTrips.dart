import 'package:flutter/material.dart';
import 'package:gantavya/agentActivity/agent_trip_list.dart';


class LastTrips extends StatefulWidget {
  const LastTrips({super.key});

  @override
  State<LastTrips> createState() => _LastTripsState();
}

class _LastTripsState extends State<LastTrips> {
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
    {"name": "Customer-1", "FromDate": "19/10/2023","ToDate":"21/11/2023"},
    {"name": "Customer-2", "FromDate": "19/10/2023","ToDate":"21/11/2023"},
    
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var data in dataList)
          Column(
            children: [
              AgentTripList(
                name: data["name"] ?? "",
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




