import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/homePage/screens/HomePage.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/NavigationPage.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/onBoardingPage.dart';
import 'package:meat_shop_app/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';


class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
 bool gotIn = false;
  getData ()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    gotIn = prefs.getBool("gotIn") ?? false;
    loginId=prefs.getString("loginUserId")??"";

    var data=await FirebaseFirestore.instance.collection("users").doc(loginId).get();
    currentUserModel=UserModel.fromMap(data.data()!);
    print(loginId);
  }
  @override
  void initState(){
    getData();
    Future.delayed(
        Duration(
      seconds: 3
    )).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>gotIn?NavigationPage():onBoardingPage(),)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: scrHeight*1,
              width: scrWidth*1,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imageConst.meetsplash),fit: BoxFit.fill,)
                )
              ),
          Container(
            height: scrHeight*1,
            width: scrWidth*1,
            decoration: BoxDecoration(
               //color: Colors.black.withOpacity(0.5),
              gradient: LinearGradient(
                begin: AlignmentDirectional(0, 1.5),
                  colors: [
                colorConst.black,
                colorConst.black.withOpacity(0.5),
              ]),
                ),
            ),
          Center(
            child: SizedBox(
              height: scrWidth*0.6,
              width: scrWidth*0.6,
              child:Column(
                children: [
              Image(image: AssetImage(imageConst.mainIcon),height: scrWidth*0.5),
              Text("Meat Shop",style: TextStyle(
                color: colorConst.white,
                fontSize: scrWidth*0.07,
                fontWeight: FontWeight.w600
              ),)
                ],
              )
            ),
          ),
          Positioned(
            bottom: scrWidth*0.2,
            left: scrWidth*0.25,
            right: scrWidth*0.25,
              child: SizedBox(
                  height: scrWidth*0.5,
                  width: scrWidth*0.5,
                  child: Lottie.asset(gifs.loadingGif))
          )
        ],
      ),
    );
  }
}
