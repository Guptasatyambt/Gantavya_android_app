import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gantavya/agentActivity/AgentMainPage.dart';
import 'package:gantavya/agentActivity/agent_profile_controller.dart';
import 'package:gantavya/provider/agent_Auth_Provider.dart';
import 'package:gantavya/welcomeScreen.dart';
import 'package:provider/provider.dart';

class AgentProfile extends StatefulWidget {
  const AgentProfile({super.key});

  @override
  State<AgentProfile> createState() => _AgentProfileState();
}

class _AgentProfileState extends State<AgentProfile> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AgentAuthProvider>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.black,
        body:ChangeNotifierProvider(
          create: (_)=>AgentProfileController(),
          child: Consumer<AgentProfileController>(
            builder: (context,provider,child){
              return  SingleChildScrollView(
                child: Center(
                    child: Padding(
                      padding:
                      const EdgeInsets.only(top: 50, left: 12.0, right: 8, bottom: 8),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const AgentMainPage()),
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          provider.image!=null?
                          CircleAvatar(
                            backgroundColor: Colors.black38,
                            backgroundImage: FileImage(File(provider.image!.path).absolute),
                            radius: 50,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: const EdgeInsets.all(0),
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    provider.pickImage(context,ap.agentModel.uid);
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ):
                          ap.agentModel.profilePic != ""
                              ? CircleAvatar(
                            backgroundColor: Colors.black38,
                            backgroundImage: NetworkImage(ap.agentModel.profilePic,),
                            radius: 50,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: const EdgeInsets.all(0),
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    provider.pickImage(context,ap.agentModel.uid);
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                              : CircleAvatar(
                            backgroundColor: Colors.white70,
                            backgroundImage:
                            const AssetImage('assets/images/user.png'),
                            radius: 50,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: const EdgeInsets.all(0),
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    provider.pickImage(context,ap.agentModel.uid);
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          ap.agentModel.name != ""
                              ? textField(
                              icon: Icons.person, data: ap.agentModel.name, edit: 1)
                              : textField(icon: Icons.person, data: "Name", edit: 1),
                          textField(
                              icon: Icons.phone_android,
                              data: ap.agentModel.phoneNumber,
                              edit: 0),
                          textField(icon: Icons.email, data: ap.agentModel.email, edit: 0),
                          textField(
                              icon: Icons.location_history,
                              data: ap.agentModel.city,
                              edit: 1),
                          textField(
                              icon: Icons.location_pin,
                              data: ap.agentModel.adress,
                              edit: 1),
                          GestureDetector(
                              onTap: () {
                                ap.userSignOut().then((value) =>
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const welcomepage()),
                                            (route) => false));
                              },
                              child:
                              textField(icon: Icons.logout, data: "Log-out", edit: 0)),
                        ],
                      ),
                    )),
              );
            },
          ),
        )
    );
  }
  Widget textField({
    required IconData icon,
    required String data,
    required int edit,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 13.0, top: 10, bottom: 15),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          Text(
            data,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.white70),
          ),
          edit == 1
              ? SizedBox(
            width: MediaQuery.of(context).size.width * .5,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              color: Colors.white,
            ),
          )
              : const Text("")
        ],
      ),
    );
  }
}
