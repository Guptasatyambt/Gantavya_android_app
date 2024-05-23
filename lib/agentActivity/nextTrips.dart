import 'package:flutter/material.dart';
import 'package:gantavya/agentActivity/agent_trip_list.dart';

class NextTrips extends StatefulWidget {
  const NextTrips({super.key});

  @override
  State<NextTrips> createState() => _NextTripsState();
}

class _NextTripsState extends State<NextTrips> {
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
    {"name": "Costomer-1", "FromDate": "16/10/23","ToDate":"24/11/2023"},
  ];

  MyList({super.key});

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




