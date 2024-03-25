import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meat_shop_app/constant/color_const.dart';
import 'package:meat_shop_app/constant/image_const.dart';

import 'main.dart';

class morePage extends StatefulWidget {
  const morePage({Key? key}) : super(key: key);

  @override
  State<morePage> createState() => _morePageState();
}

class _morePageState extends State<morePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
appBar: AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  leading: Padding(
    padding:  EdgeInsets.all(width*0.03),
    child: Container(
        child: SvgPicture.asset(iconConst.profile)),
  ),
  title: Row(
    children: [
      Text("Aneesh,",
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: width*0.05,
            color: colorConst.primaryColor
        ),),
      Text("14 Mar. 2025",
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: width*0.05,
            color: colorConst.color2
        ),),
    ],
  ),
  actions: [
   Row(
     children: [
       Container(child: SvgPicture.asset(iconConst.bag)),
       SizedBox(width: width*0.03,),
       Container(child: SvgPicture.asset(iconConst.notification)),
       SizedBox(width: width*0.04,),
     ],
   )
  ],

),
      body: Padding(
        padding:  EdgeInsets.all(width*0.03),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("General",
              style:TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: width*0.05,
              ),),
            Container(
              width: width*0.9,
              height: width*0.5,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width*0.06),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 2,
                      offset: Offset(0,4),
                      blurRadius: 4,
                    )
                  ]
              ),
              child: Padding(
                padding:  EdgeInsets.all(width*0.05),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: width*0.05,
                          width: width*0.05,
                            child: SvgPicture.asset(iconConst.profile1)
                        ),
                        SizedBox(width: width*0.03,),
                        Text("My Profile",
                          style: TextStyle(
                              color: colorConst.color2,
                              fontSize: width*0.04,
                              fontWeight: FontWeight.w400
                          ),),

                      ],

                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black12,
                        thickness: width*0.001,
                        indent: width*0.04,
                        endIndent: width*0.04,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                            height: width*0.05,
                            width: width*0.05,
                            child: SvgPicture.asset(iconConst.address)
                        ),
                        SizedBox(width: width*0.03,),
                        Text("My Address",
                          style: TextStyle(
                              color: colorConst.color2,
                              fontSize: width*0.04,
                              fontWeight: FontWeight.w400
                          ),),

                      ],

                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black12,
                        thickness: width*0.001,
                        indent: width*0.04,
                        endIndent: width*0.04,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                            height: width*0.05,
                            width: width*0.05,
                            child: SvgPicture.asset(iconConst.language)
                        ),
                        SizedBox(width: width*0.03,),
                        Text("Language",
                          style: TextStyle(
                              color: colorConst.color2,
                              fontSize: width*0.04,
                              fontWeight: FontWeight.w400
                          ),),

                      ],

                    ),


                  ],

                ),
              ),
            ),
            Text("Help And Support",
              style:TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: width*0.05,
              ),),
            Container(
              width: width*0.9,
              height: width*0.7,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width*0.06),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 2,
                      offset: Offset(0,4),
                      blurRadius: 4,
                    )
                  ]
              ),
              child: Padding(
                padding:  EdgeInsets.all(width*0.05),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Container(
                            height: width*0.05,
                            width: width*0.05,
                            child: SvgPicture.asset(iconConst.help)
                        ),
                        SizedBox(width: width*0.03,),
                        Text("Help & Support",
                          style: TextStyle(
                              color: colorConst.color2,
                              fontSize: width*0.04,
                              fontWeight: FontWeight.w400
                          ),),

                      ],

                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black12,
                        thickness: width*0.001,
                        indent: width*0.04,
                        endIndent: width*0.04,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                            height: width*0.05,
                            width: width*0.05,
                            child: SvgPicture.asset(iconConst.about)
                        ),
                        SizedBox(width: width*0.03,),
                        Text("About Us",
                          style: TextStyle(
                              color: colorConst.color2,
                              fontSize: width*0.04,
                              fontWeight: FontWeight.w400
                          ),),

                      ],

                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black12,
                        thickness: width*0.001,
                        indent: width*0.04,
                        endIndent: width*0.04,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                            height: width*0.05,
                            width: width*0.05,
                            child: SvgPicture.asset(iconConst.conditions)
                        ),
                        SizedBox(width: width*0.03,),
                        Text("Terms & Conditions",
                          style: TextStyle(
                              color: colorConst.color2,
                              fontSize: width*0.04,
                              fontWeight: FontWeight.w400
                          ),),

                      ],

                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black12,
                        thickness: width*0.001,
                        indent: width*0.04,
                        endIndent: width*0.04,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                            height: width*0.05,
                            width: width*0.05,
                            child: SvgPicture.asset(iconConst.privacy)
                        ),
                        SizedBox(width: width*0.03,),
                        Text("Privacy Policy",
                          style: TextStyle(
                              color: colorConst.color2,
                              fontSize: width*0.04,
                              fontWeight: FontWeight.w400
                          ),),

                      ],

                    ),
                  ],

                ),
              ),
            ),
            InkWell(
              onTap:(){} ,
              child: Container(
                height: width*0.14,
                width: width*0.9,
                decoration: BoxDecoration(
                    border: Border.all(color: colorConst.color1),
                    borderRadius: BorderRadius.circular(width*0.04)
                ),
                child: Center(
                  child:
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: width*0.05,
                          width: width*0.05,
                          // color: Colors.white,
                          child: Center(child: SvgPicture.asset(iconConst.logout))),
                      SizedBox(width: width*0.03,),
                      Text("Log Out",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: width*0.04,
                            color: colorConst.primaryColor
                        ),),
                    ],
                  ),

                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
