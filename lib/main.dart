import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gantavya/Activity/loading.dart';
import 'package:gantavya/agentActivity/AgentMainPage.dart';
import 'package:gantavya/agentActivity/login.dart';
import 'package:gantavya/provider/agent_Auth_Provider.dart';
import 'package:gantavya/provider/auth_provider.dart';
import 'package:gantavya/Activity/login.dart';
import 'package:gantavya/welcomeScreen.dart';
import 'package:gantavya/widegs/navigation.dart';
import 'package:provider/provider.dart';


Future main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCwXjRcbT6gtgB2VfvW8pAMA6vPrPidcdo",
      appId: "1:437097380206:android:af3169ea6038c0490da97f",
      messagingSenderId: "437097380206",
      projectId: "gantavya-5f8f2",
      storageBucket: "gantavya-5f8f2.appspot.com",
    ),
  ) : null;
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_)=>AgentAuthProvider()),
      ],
      child:
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Loading(),
        routes: {
          "/home":(context)=>  const MainPage(),
          "/login":(context)=> const RegisterScreen(),
          "/agentHome":(context)=> const AgentMainPage(),
          "/agentlogin":(context)=> const AgentLogin(),
        },

      ),
    );
  }
}


