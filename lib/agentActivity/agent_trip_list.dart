import 'package:flutter/material.dart';

class AgentTripList extends StatelessWidget {

  final String name;
  final String fromDate;
  final String toDate;

  const AgentTripList({super.key, required this.name, required this.fromDate, required this.toDate});

  @override
  Widget build(BuildContext context) {
    // String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(FromDate);
    return GestureDetector(
      onTap: () {
        // Handle the onTap action here
        print('Item $name tapped!');
        // You can navigate to a new screen, show a dialog, etc.
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0,left: 20),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                children: [
                  Text(name,style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.white70),),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Text("From Date",style:TextStyle(color: Colors.white70),),
                      const SizedBox(width: 5,),
                      Text(fromDate,style:const TextStyle(color: Colors.white70),),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Text("ToDate",style:TextStyle(color: Colors.white70),),
                      const SizedBox(width: 5,),
                      Text(toDate,style:const TextStyle(color: Colors.white70),),
                    ],
                  ),

                ],
              ),
            ),

          ],
        ),

      ),
    );

  }
}
