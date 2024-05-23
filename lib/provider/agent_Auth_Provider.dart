import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gantavya/agentActivity/otp.dart';
import 'package:gantavya/model/agent_Model.dart';
import 'package:gantavya/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgentAuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  AgentModel? _agentModel;
  AgentModel get agentModel => _agentModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AgentAuthProvider() {
    checkSign();
  }

  void checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    // getDataFromFirestore();
    fetchData();
    notifyListeners();
  }

  // signin
  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {

      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => agentOtpScreen(verificationId: verificationId),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  // verify otp
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;
      if (user != null) {
        // carry our logic
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<bool> checkExistingTraveller() async {
    DocumentSnapshot traveller =
    await _firebaseFirestore.collection("users").doc(_uid).get();
    if (traveller.exists) {
      return true;
    } else {
      return false;
    }
  }

  // DATABASE OPERTAIONS
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
    await _firebaseFirestore.collection("agents").doc(_uid).get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  void saveAgentDataToFirebaseWithoutImage({
    required BuildContext context,
    required AgentModel agentModel,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // uploading image to firebase storage.

      agentModel.profilePic = "";
      agentModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
      agentModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
      agentModel.uid = _firebaseAuth.currentUser!.uid;
      _agentModel = agentModel;

      // uploading to database
      await _firebaseFirestore
          .collection("agents")
          .doc(_uid)
          .set(agentModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  void saveAgentDataToFirebase({
    required BuildContext context,
    required AgentModel agentModel,
    required File profilePic,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    Future<String> storeFileToStorage(String ref, File file) async {
      UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    }

    try {
      // uploading image to firebase storage.
      await storeFileToStorage("agentprofilePic/$_uid", profilePic).then((value) {
        agentModel.profilePic = value;
        agentModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        agentModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        agentModel.uid = _firebaseAuth.currentUser!.uid;
      });
      _agentModel = agentModel;

      // uploading to database
      await _firebaseFirestore
          .collection("agents")
          .doc(_uid)
          .set(agentModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUserImageToFirebase({
    required BuildContext context,
    required File profilePic,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      String imageUrl =
      await storeFileToStorage("agentprofilePic/$_uid", profilePic);
      print(imageUrl);
      agentModel.profilePic = imageUrl;
      _agentModel = agentModel;
      await _firebaseFirestore
          .collection("agents")
          .doc(agentModel.uid)
          .update({'profilePic': imageUrl})
          .then((value) => showSnackBar(context, "Please Enter your Email"))
          .onError((error, stackTrace) =>
          showSnackBar(context, "Error on uploading"));

      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
      throw (e);
    }
  }

  Future<String> storeFileToStorage(String ref, File file) async {
    try {
      UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      // Handle errors related to storing file in Firebase Storage
      print("Error storing file to storage: $e");
      throw e; // Propagate the error back to the caller
    }
  }

  Future getDataFromFirestore() async {
    await _firebaseFirestore
        .collection("agents")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _agentModel = AgentModel(
        name: snapshot['name'],
        email: snapshot['email'],
        createdAt: snapshot['createdAt'],
        uid: snapshot['uid'],
        profilePic: snapshot['profilePic'],
        phoneNumber: snapshot['phoneNumber'],
        adress: snapshot['adress'],
        adhaarNumber: snapshot['adhaarNuber'],
        city: snapshot['city'],
      );
      _uid = agentModel.uid;
    });
  }

  // STORING DATA LOCALLY
  Future saveAgentDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("agent_model", jsonEncode(agentModel.toMap()));
    fetchData();
    // sendDataToAPI();
  }

  Future<void> fetchData() async {
    // API endpoint URL
    final String apiUrl = 'http://10.0.2.2:4002/booking/getall';

    try {
      // Making GET request
      final response = await http.get(Uri.parse(apiUrl));
      print(response.statusCode);
      // Decoding response
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response,
        // parse the JSON
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Process the data here if needed
        print(responseData);
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Error handling
      print('Error: $e');
      throw e;
    }
  }


  Future<void> sendDataToAPI() async {
    final Map<String, dynamic> requestData = {
      // Your data to be sent to the API
      "name":agentModel.name,
      "email":agentModel.email,
      "phone":agentModel.phoneNumber,
      "city":agentModel.city,
      "about":agentModel.adress,
      "photo":agentModel.profilePic,
      "price":"100",
      "aadhar":agentModel.adhaarNumber,
      "travelid":agentModel.uid
    };
    print(agentModel.name);
    print(agentModel.email);
    print(agentModel.phoneNumber);
    print(agentModel.city);
    print(agentModel.adress);
    print(agentModel.profilePic);
    print(agentModel.adhaarNumber);
    print(agentModel.uid);

    const String apiUrl = 'http:/192.168.144.35:4002/agent/createagent';

    try {
      var uri=Uri.parse(apiUrl);

      print(uri);
      final http.Response response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );
      print("ysssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");

      if (response.statusCode == 200) {
        // Request successful, you can handle the response here
        print('Response: ${response.body}');
      } else {
        // Request failed with an error code
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Error occurred while sending the request
      print('Error sending request: $error');
    }
  }


  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("agent_model") ?? '';
    _agentModel = AgentModel.fromMap(jsonDecode(data));
    _uid = _agentModel!.uid;
    notifyListeners();
  }

  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }
}
