import 'package:flutter/material.dart';
import 'package:gantavya/agentActivity/AgentMainPage.dart';
import 'package:gantavya/provider/agent_Auth_Provider.dart';
import 'package:gantavya/agentActivity/agentInformationScreen.dart';
import 'package:gantavya/utils/utils.dart';
import 'package:gantavya/welcomeScreen.dart';
import 'package:gantavya/widegs/custom_Button.dart';
import 'package:gantavya/widegs/navigation.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class agentOtpScreen extends StatefulWidget {
  final String verificationId;
  const agentOtpScreen({super.key, required this.verificationId});

  @override
  State<agentOtpScreen> createState() => _agentOtpScreenState();
}

class _agentOtpScreenState extends State<agentOtpScreen> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AgentAuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SingleChildScrollView(
        child: SafeArea(
          child: isLoading == true
              ? const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
              : Center(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back,color: Colors.white,),
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: Image.asset(
                      "assets/images/icon.png",
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Verification",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Enter the OTP send to your phone number",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white60,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Pinput(
                    length: 6,
                    showCursor: true,
                    defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white60,
                        ),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onCompleted: (value) {
                      setState(() {
                        otpCode = value;
                      });
                    },
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: CustomButton(
                      text:'Verify',
                      onPressed: () {
                        if (otpCode != null) {
                          verifyOtp(context, otpCode!);
                        } else {
                          showSnackBar(context, "Enter 6-Digit code");
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Didn't receive any code?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white60,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Resend New Code",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  // verify otp
  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AgentAuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        // checking whether user exists in the db
        ap.checkExistingTraveller().then((value) async{
          if(value==true){
            showSnackBar(context, "User Exits as traveller");
            Navigator.pushAndRemoveUntil(
                context,MaterialPageRoute(
                builder: (context) => const welcomepage()), (route) => false);
          }
          else{
            ap.checkExistingUser().then(
                  (value) async {
                if (value == true) {
                  // user exists in our app
                  ap.getDataFromFirestore().then(
                        (value) => ap.saveAgentDataToSP().then(
                          (value) => ap.setSignIn().then(
                            (value) => Navigator.pushAndRemoveUntil(
                            context,MaterialPageRoute(
                            builder: (context) => const AgentMainPage()), (route) => false),
                      ),
                    ),
                  );
                } else {
                  // new user
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserInfromationScreen()),
                          (route) => false);
                }
              },
            );
          }
        });

      },
    );
  }
}
