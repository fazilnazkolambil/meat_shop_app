import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meat_shop_app/feature/homePage/screens/meatList.dart';
import 'package:meat_shop_app/main.dart';
import 'package:meat_shop_app/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/provider/FirebaseProvier.dart';
import '../../onboardPage/screens/NavigationPage.dart';

final authRepositoryProvider=Provider((ref) => AuthRepository(firestore: ref.watch(firebaseProvider), auth: ref.watch(authProvider)));

class AuthRepository{
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth
}):_firestore = firestore,_auth=auth;
  
  CollectionReference get _users=> _firestore.collection("users");


  usersAuth({required UserModel userModel,required BuildContext context}){

    _auth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password).then((value) async {
          
          User? user= value.user;

          UserModel createUserModel =
          UserModel(
              name: userModel.name,
              email: user!.email.toString(),
              password: userModel.password,
              number: userModel.number,
              address: userModel.address,
              favourites: userModel.favourites,
              image: userModel.image,
              id: user.uid
          );
          var data=await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
          currentUserModel=UserModel.fromMap(data.data()!);
          
          SharedPreferences prefs =await  SharedPreferences.getInstance();
           prefs.setBool("LoggedIn", true);
          prefs.setBool("gotIn", true);
           prefs.setString("loginUserId", user.uid);

        _users.doc(user.uid).set(createUserModel.toMap());
          
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(onError.code)));
    });
    
  }



  // usersAuth(UserModel userModel){
  //   _users.add(userModel.toMap()).then((value){
  //     value.update(userModel.copyWith(id: value.id).toMap());
  //   });
  // }



}