import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';

import '../../../main.dart';

class signinPage extends StatefulWidget {
  const signinPage({Key? key}) : super(key: key);

  @override
  State<signinPage> createState() => _signinPageState();
}

class _signinPageState extends State<signinPage> {
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  bool visibility=true;
  bool check=false;
  final emailValidation=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final passwordValidation=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  elevation: 0,
  backgroundColor: Colors.white,
  leading: InkWell(
    onTap: (){

    },
    child: Container(
      height: scrWidth*0.02,
      width: scrHeight*0.02,
      child: Center(child: SvgPicture.asset(iconConst.backarrow),),
    ),
  ),
),
      body: Column(
children: [
  Center(
    child: Container(
      height: scrWidth*0.3,
      width: scrWidth*0.3,
      padding: EdgeInsets.only(left: scrWidth*0.07),
      decoration: BoxDecoration(
          image:DecorationImage(image: AssetImage(imageConst.logo),fit: BoxFit.fill)
      ),

    ),
  ),

],
      ),
    );
  }
}
