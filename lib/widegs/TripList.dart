import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TripList extends StatelessWidget {

  final String city;
  final String image;
  final String fromDate;
  final String toDate;


  const TripList({super.key, required this.city, required this.image, required this.fromDate, required this.toDate});

  @override
  Widget build(BuildContext context) {
    // String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(FromDate);
    return GestureDetector(
      onTap: () {
        // Handle the onTap action here
        print('Item $city tapped!');
        // You can navigate to a new screen, show a dialog, etc.
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0,left: 20),
        child: Row(
          children: [
            Image.network(image, height: 120, width: 80),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                children: [
                  Text(city,style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.white70),),
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
