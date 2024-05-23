import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyListItem extends StatelessWidget {
  final String name;
  final String city;
  final String rating;

  const MyListItem({super.key, required this.name, required this.city, required this.rating});

  @override
  Widget build(BuildContext context) {
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
            Image.network("https://happay.com/blog/wp-content/uploads/sites/12/2022/09/Business-Travel-Management-_1_-scaled-1.webp", height: 100, width: 80),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                children: [
                  Text(name,style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.white70),),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Text("City",style:TextStyle(color: Colors.white70),),
                      const SizedBox(width: 10,),
                      Text(city,style:const TextStyle(color: Colors.white70),),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Text("Rating",style:TextStyle(color: Colors.white70),),
                      const SizedBox(width: 10,),
                      Text(rating,style:const TextStyle(color: Colors.white70),),
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