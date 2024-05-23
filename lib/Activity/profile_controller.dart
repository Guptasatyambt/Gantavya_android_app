import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gantavya/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController with ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;


final picker=ImagePicker();
File? _image;
File? get image=>_image;

Future pickGalleryImage(BuildContext context) async{
  final pickedFile=await picker.pickImage(source: ImageSource.gallery);

  if(pickedFile!=null){
    _image=File(pickedFile.path);
    updateUserImageToFirebase(context:context,profilePic: _image!);
    notifyListeners();
  }
}
Future pickCameraImage(BuildContext context) async{
  final pickedFile=await picker.pickImage(source: ImageSource.camera);

  if(pickedFile!=null){
    _image=File(pickedFile.path);
    updateUserImageToFirebase(context:context,profilePic: _image!);
    notifyListeners();
  }
}

  void pickImage(context,String uid){
  _uid=uid;
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        content: Container(
          height: 120,
          child: Column(
            children: [
              ListTile(
                onTap: (){
                  pickCameraImage(context);
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
              ),
              ListTile(
                onTap: (){
                  pickGalleryImage(context);
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo),
                title: const Text("Gallery"),
              ),
            ],
          ),
        ),
      );
    });
  }
  void updateUserImageToFirebase({
    required context,
    required File profilePic,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      String imageUrl =
      await storeFileToStorage("profilePic/$_uid", profilePic);

      await _firebaseFirestore
          .collection("users")
          .doc(_uid)
          .update({'profilePic': imageUrl})
          .then((value) => showSnackBar(context, "Image uploaded"))
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
      throw e; // Propagate the error back to the caller
    }
  }
}

