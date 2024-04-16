import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/morePage/screens/EditProfile.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/onBoardingPage.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../homePage/screens/meatList.dart';
import '../../ordersPage/screens/cart_page.dart';

class morePage extends StatefulWidget {
  const morePage({Key? key}) : super(key: key);

  @override
  State<morePage> createState() => _morePageState();
}

class _morePageState extends State<morePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConst.white,
      appBar: AppBar(
        backgroundColor: colorConst.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(scrWidth * 0.03),
          child: SvgPicture.asset(iconConst.profile),
        ),
        title: Row(
          children: [
            Text(
              "Aneesh,",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: scrWidth * 0.045,
                  color: colorConst.meroon),
            ),
            Text(
              "14 Mar. 2025",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: scrWidth * 0.037,
                // color: colorConst.color2
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => cartPage(),
                        ));
                  },
                  child: addCart.isEmpty
                      ? SvgPicture.asset(iconConst.cart)
                      : SizedBox(
                          height: scrWidth * 0.08,
                          width: scrWidth * 0.08,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: scrWidth * 0.03,
                                left: scrWidth * 0.03,
                                child: CircleAvatar(
                                  backgroundColor: colorConst.meroon,
                                  radius: scrWidth * 0.025,
                                  child: Center(
                                    child: Text(
                                      addCart.length.toString(),
                                      style: TextStyle(
                                          color: colorConst.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: scrWidth * 0.03),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  bottom: 0,
                                  child: SvgPicture.asset(
                                    iconConst.cart,
                                  )),
                            ],
                          ),
                        )),
              SizedBox(
                width: scrWidth * 0.03,
              ),
              SvgPicture.asset(iconConst.notification),
              SizedBox(
                width: scrWidth * 0.04,
              ),
            ],
          )
        ],
      ),
      body: SizedBox(
        height: scrHeight*0.8,
        child: Padding(
          padding: EdgeInsets.all(scrWidth * 0.03),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "General",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: scrWidth * 0.044,
                  ),
                ),
                Container(
                  width: scrWidth * 0.9,
                  height: scrHeight * 0.26,
                  margin: EdgeInsets.only(
                      bottom: scrWidth * 0.05, top: scrWidth * 0.05),
                  decoration: BoxDecoration(
                      color: colorConst.white,
                      borderRadius: BorderRadius.circular(scrWidth * 0.04),
                      boxShadow: [
                        BoxShadow(
                          color: colorConst.black.withOpacity(0.1),
                          spreadRadius: 1,
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        )
                      ]),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Center(child: Text('My Profile',style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: scrWidth*0.055
                                ),)),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:
                                  [
                                    CircleAvatar(
                                      radius: scrWidth*0.17,
                                    ),
                                    Text('John Doe',style: TextStyle(
                                      fontSize: scrWidth*0.044,
                                      fontWeight: FontWeight.w600
                                    ),),
                                    Text('5674843290',style: TextStyle(
                                        fontSize: scrWidth*0.044,
                                        fontWeight: FontWeight.w500
                                    ),),
                                    Text('john@gmail.com',style: TextStyle(
                                        fontSize: scrWidth*0.044,
                                        fontWeight: FontWeight.w500
                                    ),),

                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditProfile(),));
                                    },
                                    child: Center(child: Text('Edit Profile',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: scrWidth*0.04,
                                      color: colorConst.meroon
                                    ),)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: ListTile(
                          leading: SvgPicture.asset(iconConst.profile1),
                          title: Text(
                            "My Profile",
                            style: TextStyle(
                                fontSize: scrWidth * 0.04,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.black12,
                        thickness: scrWidth * 0.001,
                        indent: scrWidth * 0.04,
                        endIndent: scrWidth * 0.04,
                      ),
                      ListTile(
                        leading: SvgPicture.asset(iconConst.address),
                        title: Text(
                          "My Address",
                          style: TextStyle(
                              fontSize: scrWidth * 0.04,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Divider(
                        color: Colors.black12,
                        thickness: scrWidth * 0.001,
                        indent: scrWidth * 0.04,
                        endIndent: scrWidth * 0.04,
                      ),
                      ListTile(
                        leading: SvgPicture.asset(iconConst.language),
                        title: Text(
                          "Language",
                          style: TextStyle(
                              fontSize: scrWidth * 0.04,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Help And Support",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: scrWidth * 0.044,
                  ),
                ),
                Container(
                  width: scrWidth * 0.9,
                  height: scrHeight * 0.35,
                  margin: EdgeInsets.only(
                      bottom: scrWidth * 0.05, top: scrWidth * 0.05),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(scrWidth * 0.04),
                      boxShadow: [
                        BoxShadow(
                          color: colorConst.black.withOpacity(0.1),
                          spreadRadius: 1,
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        )
                      ]),
                  child: Column(
                    children: [
                      ListTile(
                        leading: SvgPicture.asset(iconConst.help),
                        title: Text(
                          "Help & Support",
                          style: TextStyle(
                              fontSize: scrWidth * 0.04,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Divider(
                        color: Colors.black12,
                        thickness: scrWidth * 0.001,
                        indent: scrWidth * 0.04,
                        endIndent: scrWidth * 0.04,
                      ),
                      ListTile(
                        leading: SvgPicture.asset(iconConst.about),
                        title: Text(
                          "About Us",
                          style: TextStyle(
                              fontSize: scrWidth * 0.04,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Divider(
                        color: Colors.black12,
                        thickness: scrWidth * 0.001,
                        indent: scrWidth * 0.04,
                        endIndent: scrWidth * 0.04,
                      ),
                      ListTile(
                        leading:  SvgPicture.asset(iconConst.conditions),
                        title: Text(
                          "Terms & Conditions",
                          style: TextStyle(
                              fontSize: scrWidth * 0.04,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Divider(
                        color: Colors.black12,
                        thickness: scrWidth * 0.001,
                        indent: scrWidth * 0.04,
                        endIndent: scrWidth * 0.04,
                      ),
                      ListTile(
                        leading:  SvgPicture.asset(iconConst.privacy),
                        title: Text(
                          "Privacy Policy",
                          style: TextStyle(
                              fontSize: scrWidth * 0.04,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove("LoggedIn");
                    prefs.remove("gotIn");
                    prefs.remove("loginUserId");
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => splashScreen(),
                        ),
                        (route) => false);
                  },
                  child: Container(
                    height: scrWidth * 0.14,
                    width: scrWidth * 0.9,
                    decoration: BoxDecoration(
                        border: Border.all(color: colorConst.grey1),
                        borderRadius: BorderRadius.circular(scrWidth * 0.04)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: scrWidth * 0.05,
                              width: scrWidth * 0.05,
                              // color: Colors.white,
                              child: Center(
                                  child: SvgPicture.asset(iconConst.logout))),
                          SizedBox(
                            width: scrWidth * 0.03,
                          ),
                          Text(
                            "Log Out",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: scrWidth * 0.04,
                              // color: colorConst.primaryColor
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
