import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gantavya/agentActivity/AgentMainPage.dart';
import 'package:gantavya/provider/agent_Auth_Provider.dart';
import 'package:gantavya/provider/auth_provider.dart';
import 'package:gantavya/welcomeScreen.dart';
import 'package:gantavya/widegs/navigation.dart';
import 'package:provider/provider.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<void> startApp(BuildContext context) async {
    final ap = Provider.of<AuthProvider>(context, listen: true);
    final agentap=Provider.of<AgentAuthProvider>(context, listen: true);
     void entryFunction() async{
       if (ap.isSignedIn == true && agentap.isSignedIn == false) {
         await ap.getDataFromSP().whenComplete(
               () => Navigator.pushReplacement(
             context,
             MaterialPageRoute(
               builder: (context) => const MainPage(),
             ),
           ),
         );
       }
        else if (agentap.isSignedIn == true && ap.isSignedIn == false) {
         await agentap.getDataFromSP().whenComplete(
               () => Navigator.pushReplacement(
             context,
             MaterialPageRoute(
               builder: (context) => const AgentMainPage(),
             ),
           ),
         );
       } else {
         Navigator.pushReplacement(
           context,
           MaterialPageRoute(
             builder: (context) => const welcomepage(),
           ),
         );
       }
     }
    try {
      await Future.delayed(const Duration(seconds: 1));
      entryFunction();
    } catch (error) {
      // Handle errors, log them, or show an error message
      print('Error during app initialization: $error');
      // For example, navigate to a login screen on error
      MaterialPageRoute(
        builder: (context) => const welcomepage(),
        //testing purpose change it to MainPage(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    startApp(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/logo.png", width: 240, height: 240),
            const Text(
              "Gantavya",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SpinKitCircle(
              color: Colors.white,
              size: 50.0,
            ),
            const SizedBox(height: 200),
            const Text(
              "Founder - Satyam Gupta",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      backgroundColor: Colors.black38,
    );
  }
}
