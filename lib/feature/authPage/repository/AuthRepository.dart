import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meat_shop_app/models/userModel.dart';

import '../../../core/provider/FirebaseProvier.dart';

final authRepositoryProvider=Provider((ref) => AuthRepository(firestore: ref.watch(firebaseProvider)));

class AuthRepository{
  final FirebaseFirestore _firestore;
  AuthRepository({
    required FirebaseFirestore firestore
}):_firestore = firestore;
  
  CollectionReference get _auth=> _firestore.collection("users");
  
  usersAuth(UserModel userModel){
    _auth.add(userModel.toMap()).then((value){
      value.update(userModel.copyWith(id: value.id).toMap());
    });
  }
  
}