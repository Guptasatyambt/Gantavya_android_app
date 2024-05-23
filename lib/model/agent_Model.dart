class AgentModel {
  String name;
  String email;
  String profilePic;
  String createdAt;
  String phoneNumber;
  String adress;
  String adhaarNumber;
  String city;
  String uid;

  AgentModel({
    required this.name,
    required this.email,
    required this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    required this.adress,
    required this.adhaarNumber,
    required this.city,
    required this.uid,
  });

  // from map
  factory AgentModel.fromMap(Map<String, dynamic> map) {
    return AgentModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
      profilePic: map['profilePic'] ?? '',
      adress: map['adress'] ?? '',
      adhaarNumber: map['adhaarNumber']?? '',
      city: map['city']?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "adress":adress,
      "adhaarNuber":adhaarNumber,
      "city":city,
    };
  }
}
