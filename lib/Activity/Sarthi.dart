import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gantavya/widegs/custom_Button.dart';
import 'package:intl/intl.dart';
import 'package:gantavya/widegs/List.dart';

class Sarthi extends StatefulWidget {
  const Sarthi({Key? key}) : super(key: key);

  @override
  State<Sarthi> createState() => _SarthiState();
}

class _SarthiState extends State<Sarthi> {
  final TextEditingController _fromdate= TextEditingController();
  final TextEditingController _todate= TextEditingController();
  final TextEditingController _destination= TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
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
      body:  SingleChildScrollView(
        child: Column(
          children: [
            Column(
                children: [
                  const SizedBox(height: 20,),
                  const Text("Book Your Journey Now !",style:TextStyle(fontWeight: FontWeight.w500,fontSize:20,color: Colors.white70),),
                  TextField(
                    style: const TextStyle(color: Colors.white70),
                    cursorColor: Colors.yellow,
                             controller: _fromdate,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.calendar_today,color: Colors.white38,),
                                labelText: "From Date",
                                labelStyle: TextStyle(color: Colors.white38),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white38,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.yellow),
                                ),

                              ),
                              onTap: ()async{
                               DateTime? pickeddate= await showDatePicker(
                                   context: context,
                                   initialDate: DateTime.now(),
                                   firstDate: DateTime.now(),
                                   lastDate: DateTime(2101)
                               );
                               if(pickeddate!=null){
                                 setState(() {
                                   _fromdate.text=DateFormat('yyyy-MM-dd').format(pickeddate);
                                 });
                               }
                              },
                            ),
                  const SizedBox(height: 20,),
                  TextField(
                    cursorColor: Colors.yellow,
                    style: const TextStyle(color: Colors.white70),
                    controller: _todate,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today, color: Colors.white38),
                        labelText: "To Date",
                        labelStyle: TextStyle(color: Colors.white38),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white38,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow),
                      ),

                    ),
                    onTap: ()async{
                      DateTime? pickeddate= await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101)
                      );
                      if (pickeddate != null) {
                        setState(() {
                          _todate.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    cursorColor: Colors.yellow,
                    style: const TextStyle(color: Colors.white70),
                    controller: _destination,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.place, color: Colors.white38),
                        labelText: "Destination",
                        labelStyle: TextStyle(color: Colors.white38),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white38,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow),
                      ),
                    ),
                    onTap: ()async{


                    },
                  ),











                  const SizedBox(height: 20,),
                  CustomButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      print('Entered text:');
                    },
                    text:'Book Your Sarthi',
                  ),
                   Column(
                    children: [
                      GestureDetector(
                       onTap: (){
                         FocusScope.of(context).unfocus();
                              },
                          child: MyList()
                      ),
                    ],
                  ),
                ],
              ),

          ],
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

