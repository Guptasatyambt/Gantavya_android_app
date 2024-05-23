import 'package:flutter/material.dart';
import 'package:gantavya/widegs/custom_Button.dart';

class welcomepage extends StatefulWidget {
  const welcomepage({super.key});

  @override
  State<welcomepage> createState() => _welcomepageState();
}

class _welcomepageState extends State<welcomepage> {
  String selectedValue = 'Traveler';
  List<String> dropdownItems = ['Traveler', 'Sarthi'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    "assets/images/icon.png",
                    width: 190,
                    height: 190,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 58.0),
                child: Row(
                  children: [
                    const Text(
                      "Log_in as-",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(width: 25),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<String>(
                          dropdownColor: Colors.white70,
                          focusColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                          value: selectedValue,
                          items: dropdownItems.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                "Log_in With",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 25),
              selectedValue == 'Traveler'
                  ? Column(
                      children: [
                        button(
                            text: "Phone",
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            }),
                        button(
                            text: "E-Mail",
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            }),
                        button(
                            text: "Google",
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            }),
                        button(
                            text: "Facebook",
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            })
                      ],
                    )
                  : Column(
                      children: [
                        button(
                            text: "Phone",
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/agentlogin');
                            }),
                        button(
                            text: "E-Mail",
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/agentlogin');
                            }),
                        button(
                            text: "Google",
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/agentlogin');
                            }),
                        button(
                            text: "Facebook",
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/agentlogin');
                            }),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget button({
    required String text,
    required Function() onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size>(
            Size(MediaQuery.of(context).size.width * 0.8,
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
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
