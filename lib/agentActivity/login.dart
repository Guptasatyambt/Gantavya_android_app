import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:gantavya/provider/agent_Auth_Provider.dart';
import 'package:gantavya/utils/utils.dart';
import 'package:gantavya/widegs/custom_Button.dart';
import 'package:provider/provider.dart';

class AgentLogin extends StatefulWidget {
  const AgentLogin({super.key});

  @override
  State<AgentLogin> createState() => _AgentLogin();
}

class _AgentLogin extends State<AgentLogin> {
  final TextEditingController phoneController = TextEditingController();

  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
              child: Column(
                children: [
                  Container(
                    width: 250,
                    height: 250,
                    padding: const EdgeInsets.all(20.0),

                    child: Image.asset(
                      "assets/images/icon.png",width: 190,height: 190,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Add your phone number. We'll send you a verification code",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    cursorColor: Colors.white,
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                    onChanged: (value) {
                      setState(() {
                        phoneController.text = value;
                      });
                    },

                    decoration: InputDecoration(
                      hintText: "Enter phone number",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.white60,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white54),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white60),
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.only(top: 13.0,right: 8,left:8),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                                context: context,
                                countryListTheme: const CountryListThemeData(
                                  bottomSheetHeight: 550,
                                ),
                                onSelect: (value) {
                                  setState(() {
                                    selectedCountry = value;
                                  });
                                });
                          },
                          child: Text(
                            "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      suffixIcon: phoneController.text.length > 9
                          ? Container(
                        height: 30,
                        width: 30,
                        margin: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        child: const Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 20,
                        ),
                      )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      onPressed: () =>sendPhoneNumber(),
                      text:'Log-In',
                    ),

                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AgentAuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    phoneNumber.length>9
        ? ap.signInWithPhone(context, "+${selectedCountry.phoneCode}$phoneNumber")
        :showSnackBar(context, "Enter a valid Number");
  }
}
