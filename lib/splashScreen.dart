import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meat_shop_app/constant/color_const.dart';
import 'package:meat_shop_app/constant/image_const.dart';

import 'main.dart';

class spllashScreen extends StatefulWidget {
  const spllashScreen({super.key});

  @override
  State<spllashScreen> createState() => _spllashScreenState();
}

class _spllashScreenState extends State<spllashScreen> {

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
          )
          //Center(child: Image(image: AssetImage(imageConst.mainIcon),height: w*0.5,)),
          //Center(child: Text("Meat Shop"))
        ],
      ),
    );
  }
}
