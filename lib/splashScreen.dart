import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/constant/color_const.dart';
import 'package:meat_shop_app/constant/image_const.dart';
import 'package:meat_shop_app/onBoardingPage.dart';

import 'main.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState(){
    Future.delayed(Duration(
      seconds: 5
    )).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => onBoardingPage(),)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(image: AssetImage(imageConst.meetsplash)),
          Container(
            height: h*1,
            width: w*1,
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
              height: w*0.6,
              width: w*0.6,
              child:Column(
                children: [
              Image(image: AssetImage(imageConst.mainIcon),height: w*0.5),
              Text("Meat Shop",style: TextStyle(
                color: colorConst.white,
                fontSize: w*0.07,
                fontWeight: FontWeight.w600
              ),)
                ],
              )
            ),
          ),
          Positioned(
            bottom: w*0.2,
            left: w*0.25,
            right: w*0.25,
              child: SizedBox(
                  height: w*0.5,
                  width: w*0.5,
                  child: Lottie.asset(gifs.loadingGif)))
        ],
      ),
    );
  }
}
