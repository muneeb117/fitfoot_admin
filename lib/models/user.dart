import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String name;
  String uid;
  String image;
  String email;
  UserModel({
    required this.name,
    required this.uid,
    required this.image,
    required this.email,

  });
  Map<String,dynamic> toJson()=>
      {
        "name":name,
        "uid":uid,
        "image":image,
        "email":email,

      };
  static UserModel fromSnap(DocumentSnapshot snapshot){
    var dataSnapshot=snapshot.data() as Map<String, dynamic>;
    return UserModel(
      name: dataSnapshot["name"],
      uid: dataSnapshot["uid"],
      image: dataSnapshot["image"],
      email: dataSnapshot["email"],
    );


  }
}

