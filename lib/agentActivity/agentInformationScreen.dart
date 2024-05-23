import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gantavya/Activity/login.dart';
import 'package:gantavya/agentActivity/AgentMainPage.dart';
import 'package:gantavya/agentActivity/login.dart';
import 'package:gantavya/model/agent_Model.dart';
import 'package:gantavya/provider/agent_Auth_Provider.dart';
import 'package:gantavya/utils/utils.dart';
import 'package:gantavya/widegs/custom_Button.dart';
import 'package:gantavya/widegs/navigation.dart';
import 'package:provider/provider.dart';

class UserInfromationScreen extends StatefulWidget {
  const UserInfromationScreen({super.key});

  @override
  State<UserInfromationScreen> createState() => _UserInfromationScreenState();
}

class _UserInfromationScreenState extends State<UserInfromationScreen> {
  File? image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final adharController=TextEditingController();
  final cityController=TextEditingController();
  final adressController=TextEditingController();
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    adharController.dispose();
    cityController.dispose();
    adressController.dispose();
  }

  // for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AgentAuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SafeArea(
        child: isLoading == true
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        )
            : SingleChildScrollView(
          padding:
          const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
          child: Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () => selectImage(),
                  child: image == null
                      ? const CircleAvatar(
                    backgroundColor: Colors.black38,
                    radius: 50,
                    child: Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.white,
                    ),
                  )
                      : CircleAvatar(
                    backgroundImage:FileImage(image!),
                    radius: 50,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 15),
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      // name field
                      textFeld(
                        hintText: "John Smith",
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: nameController,
                      ),

                      // email
                      textFeld(
                        hintText: "abc@example.com",
                        icon: Icons.email,
                        inputType: TextInputType.emailAddress,
                        maxLines: 1,
                        controller: emailController,
                      ),
                      //city
                      textFeld(
                        hintText: "city here",
                        icon: Icons.mode_of_travel_sharp,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: cityController,
                      ),
                      //adress
                      textFeld(
                        hintText: "adress here",
                        icon: Icons.place,
                        inputType: TextInputType.name,
                        maxLines: 2,
                        controller: adressController,
                      ),
                      //adhar
                      textFeld(
                        hintText: "aadhar number",
                        icon: Icons.domain_verification_outlined,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: adharController,
                      ),


                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: CustomButton(
                    text:'Continue',
                    onPressed: () => storeData(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Colors.white,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white70,
        ),
        decoration: InputDecoration(
          fillColor:Colors.transparent,
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black38,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white10,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white54,
            ),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white38,
            fontWeight: FontWeight.w500,
            fontSize: 15,),
          alignLabelWithHint: true,
          border: InputBorder.none,
          // fillColor: Colors.white60,
          filled: true,
        ),
      ),
    );
  }

  // store user data to database
  void storeData() async {
    final ap = Provider.of<AgentAuthProvider>(context, listen: false);

    try {
      if (emailController.text == "") {
        showSnackBar(context, "Please Enter your Email");
      }

      else {
        AgentModel agentModel = AgentModel(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          profilePic: "",
          createdAt: "",
          phoneNumber: "",
          uid: "",
          adress: adressController.text.trim(),
          adhaarNumber: adharController.text.trim(),
          city: cityController.text.trim(),
        );


        if (image != null) {
          ap.saveAgentDataToFirebase(
            context: context,
            agentModel: agentModel,
            profilePic: image!,
            onSuccess: () {
              ap.saveAgentDataToSP().then(
                    (value) =>
                    ap.setSignIn().then(
                          (value) =>
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AgentMainPage(),
                              ),
                                  (route) => false),
                    ),
              );
            },
          );
        }
        else {
          ap.saveAgentDataToFirebaseWithoutImage(
            context: context,
            agentModel: agentModel,
            onSuccess: () {
              ap.saveAgentDataToSP().then(
                    (value) =>
                    ap.setSignIn().then(
                          (value) =>
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AgentMainPage(),
                              ),
                                  (route) => false),
                    ),
              );
            },
          );
        }
      }
    }catch(e){
      showSnackBar(context, "We are Sorry! Currently we are fetching some problem");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const AgentLogin(),
          ),
              (route) => false);
    }
  }


}
