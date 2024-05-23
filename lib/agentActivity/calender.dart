import 'package:flutter/material.dart';
import 'package:gantavya/agentActivity/AgentMainPage.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  final List<DateTime> specialDates = [
    DateTime(2024, 1, 15), // Specify your specific date(s) here
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading:IconButton(onPressed: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AgentMainPage()),
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
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: SfCalendar(
                view: CalendarView.month,
                
                todayHighlightColor: Colors.yellow,
                cellBorderColor: Colors.transparent,

                headerHeight: 40,
                headerStyle: CalendarHeaderStyle(textStyle: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.w500,fontSize: 20)),
                blackoutDatesTextStyle: TextStyle(color: Colors.white),
                todayTextStyle: TextStyle(color: Colors.black),
                monthViewSettings: MonthViewSettings(
                  navigationDirection: MonthNavigationDirection.vertical,
                    numberOfWeeksInView: 6,
                    monthCellStyle: MonthCellStyle(
                      textStyle: TextStyle(color: Colors.grey.shade300),
                      trailingDatesTextStyle:
                      TextStyle(fontSize: 15, color: Colors.white70),
                      leadingDatesTextStyle:
                      TextStyle(fontSize: 15, color: Colors.white70),
                    )),
              ),
            ),
          ElevatedButton( style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(
              Size(MediaQuery.of(context).size.width * 0.6,
                  50), // Set width and height
            ),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black38),
            backgroundColor:
            MaterialStateProperty.all<Color>(Colors.yellow.shade700),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),onPressed: (){}, child: Text("Make Unavailable"))
        ],
      ),
    );
  }
  
}
