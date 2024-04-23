import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meat_shop_app/feature/authPage/repository/AuthRepository.dart';
import 'package:meat_shop_app/models/userModel.dart';

import '../repository/AuthRepository.dart';
import '../repository/AuthRepository.dart';

final authControllerProvider=Provider((ref) => AuthController(AuthRepository: ref.watch(authRepositoryProvider)));

class AuthController{
  final AuthRepository _authRepository;
  AuthController({
    required AuthRepository
}):_authRepository= AuthRepository;

  adding({required UserModel userModel,required BuildContext context}){
    _authRepository.usersAuth(userModel: userModel, context: context);
  }

}