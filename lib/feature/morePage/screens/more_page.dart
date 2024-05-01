import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/homePage/screens/HomePage.dart';
import 'package:meat_shop_app/feature/morePage/screens/EditProfile.dart';
import 'package:meat_shop_app/feature/morePage/screens/myaddress.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/onBoardingPage.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../authPage/screens/info_page.dart';
import '../../authPage/screens/signin_page.dart';
import '../../homePage/screens/meatList.dart';
import '../../onboardPage/screens/NavigationPage.dart';
import '../../ordersPage/screens/cart_page.dart';

class morePage extends StatefulWidget {
  const morePage({Key? key}) : super(key: key);

  @override
  State<morePage> createState() => _morePageState();
}

class _morePageState extends State<morePage> {
  String username = "User";
  String email = "";
  String phonenumber = "";
  String id = "";
  String? userImage;

  getUser() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .where("id", isEqualTo: loginId)
        .get();
    print(data.docs[0]["image"]);
    username = data.docs[0]['name'];
    email = data.docs[0]['email'];
    phonenumber = data.docs[0]['number'];
    id = data.docs[0]['id'];
    userImage = data.docs[0]['image'] ?? "";
    setState(() {});
  }

  @override
  void initState() {
    getUser();
    // TODO: implement initState
    super.initState();
  }

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
        title: Text(
          username,
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: scrWidth * 0.045,
              color: colorConst.meroon),
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
        height: scrHeight * 0.8,
        width: scrWidth,
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
                Center(
                  child: Container(
                    width: scrWidth*0.9,
                    margin: EdgeInsets.only(bottom: scrWidth * 0.05, top: scrWidth * 0.05),
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
                                return loginId == ""
                                    ? AlertDialog(
                                        title: Lottie.asset(gifs.login),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text("You haven't registered yet!",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: scrWidth * 0.04)),
                                            SizedBox(
                                              height: scrHeight * 0.01,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          infoPage(
                                                        path: '',
                                                      ),
                                                    ));
                                              },
                                              child: Container(
                                                height: scrHeight * 0.05,
                                                width: scrWidth * 0.4,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            scrWidth * 0.03),
                                                    border: Border.all(
                                                        color:
                                                            colorConst.meroon)),
                                                child: Center(
                                                  child: Text("Sign Up"),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: scrHeight * 0.01,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          signinPage(
                                                        path: 'MeatPage',
                                                      ),
                                                    ));
                                              },
                                              child: Container(
                                                height: scrHeight * 0.05,
                                                width: scrWidth * 0.4,
                                                decoration: BoxDecoration(
                                                    color: colorConst.meroon,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            scrWidth * 0.03),
                                                    border: Border.all(
                                                        color:
                                                            colorConst.meroon)),
                                                child: Center(
                                                  child: Text(
                                                    "Log In",
                                                    style: TextStyle(
                                                        color: colorConst.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : AlertDialog(
                                        title: Center(
                                            child: Text(
                                          'My Profile',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: scrWidth * 0.055),
                                        )),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            userImage!.isNotEmpty
                                                ? CircleAvatar(
                                                    radius: scrWidth * 0.17,
                                                    backgroundImage:
                                                        NetworkImage(userImage!),
                                                  )
                                                : CircleAvatar(
                                                    radius: scrWidth * 0.17,
                                                    backgroundImage: AssetImage(
                                                        imageConst.logo),
                                                  ),
                                            Text(
                                              username,
                                              style: TextStyle(
                                                  fontSize: scrWidth * 0.044,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              phonenumber,
                                              style: TextStyle(
                                                  fontSize: scrWidth * 0.044,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              email,
                                              style: TextStyle(
                                                  fontSize: scrWidth * 0.044,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditProfile(
                                                      id: id,
                                                      image: userImage!,
                                                      username: username,
                                                      email: email,
                                                      phonenumber: phonenumber,
                                                    ),
                                                  ));
                                            },
                                            child: Center(
                                                child: Text(
                                              'Edit Profile',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: scrWidth * 0.04,
                                                  color: colorConst.meroon),
                                            )),
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
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => myaddress(),));
                          },
                          child: ListTile(
                            leading: SvgPicture.asset(iconConst.address),
                            title: Text(
                              "My Address",
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
                ),
                Text(
                  "Help And Support",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: scrWidth * 0.044,
                  ),
                ),
                Center(
                  child: Container(
                    width: scrWidth * 0.9,
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
                          leading: SvgPicture.asset(iconConst.conditions),
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
                          leading: SvgPicture.asset(iconConst.privacy),
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
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Are you sure you want to LogOut?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: scrWidth*0.04,
                                fontWeight: FontWeight.w600
                            ),),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: scrWidth*0.08,
                                  width: scrWidth*0.2,
                                  decoration: BoxDecoration(
                                    color: colorConst.textgrey,
                                    borderRadius: BorderRadius.circular(scrWidth*0.03),
                                  ),
                                  child: Center(child: Text("No",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),)),
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
                                        builder: (context) => NavigationPage(),
                                      ),
                                          (route) => false);
                                },
                                child: Container(
                                  height: scrWidth*0.08,
                                  width: scrWidth*0.2,
                                  decoration: BoxDecoration(
                                    color: colorConst.meroon,
                                    borderRadius: BorderRadius.circular(scrWidth*0.03),
                                  ),
                                  child: Center(child: Text("Yes",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),)),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Center(
                    child: Container(
                      height: scrWidth * 0.14,
                      width: scrWidth * 0.9,
                      decoration: BoxDecoration(
                        color: colorConst.white,
                          border: Border.all(color: colorConst.grey.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(scrWidth * 0.04),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(iconConst.logout),
                            SizedBox(
                              width: scrWidth * 0.03,
                            ),
                            Text(
                              "Log Out",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: scrWidth * 0.04,
                                color: colorConst.meroon
                                // color: colorConst.primaryColor
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: scrHeight*0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
