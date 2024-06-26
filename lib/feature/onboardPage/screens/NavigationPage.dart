import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:meat_shop_app/Image_Page.dart';
// import 'package:meat_shop_app/constant/Color_Page.dart';

import '../../../main.dart';
import '../../favoritePage/screens/favourite_page.dart';
import 'HomePage.dart';
import '../../morePage/screens/more_page.dart';
import '../../ordersPage/screens/My_Orders.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}
String loginId = '';

class _NavigationPageState extends State<NavigationPage> {
  final _controller = NotchBottomBarController(index: 0);
  final _pageController = PageController(initialPage: 0);
  int maxCount = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List bottomBarPages = [
    HomePage(),
    MyOrders(),
    favouritePage(),
    morePage(),
  ];
  int selectedIndex = 0;
  void onItemTapped(int Index) {
    setState(() {
      selectedIndex = Index;
    });
  }
  bool login = false;
  UserModel? users;
  String? userImage;
  getData () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    login = prefs.getBool("LoggedIn") ?? false;
    loginId = prefs.getString("loginUserId") ?? "";
    if(loginId.isNotEmpty){
      await FirebaseFirestore.instance.collection("users").doc(loginId).get().then((value) {
        users = UserModel.fromMap(value.data()!);
        userImage = users!.image;
      });
    }
    setState(() {

    });
  }
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              showBottomRadius: false,
              showTopRadius: false,
              notchBottomBarController: _controller,
              color: colorConst.white,
              showLabel: true,
              itemLabelStyle: TextStyle(
                  color: colorConst.textgrey,
                  fontSize: scrWidth * 0.03,
                  fontWeight: FontWeight.w500),
              notchColor: colorConst.meroon,
              removeMargins: false,
              bottomBarWidth: scrWidth * 1,
              showShadow: false,
              durationInMilliSeconds: 200,
              kIconSize: scrWidth*0.06,
              kBottomRadius: scrWidth*0.03,
              bottomBarItems: [
                BottomBarItem(
                  inActiveItem: SvgPicture.asset(
                    iconConst.home,
                  ),
                  activeItem: SvgPicture.asset(
                    iconConst.home,
                    color: colorConst.white,
                  ),
                  itemLabel: 'Home',
                ),
                BottomBarItem(
                  inActiveItem: SvgPicture.asset(
                    iconConst.cart
                  ),
                  activeItem: SvgPicture.asset(
                    iconConst.cart,
                    color: colorConst.white,
                  ),
                  itemLabel: 'orders',
                ),
                BottomBarItem(
                  inActiveItem: Icon(Icons.favorite,color: colorConst.meroon,),
                  activeItem: Icon(Icons.favorite_border,color: colorConst.white),
                  itemLabel: 'Favourite',
                ),
                BottomBarItem(
                    inActiveItem: SvgPicture.asset(
                      iconConst.more,
                    ),
                    activeItem: SvgPicture.asset(
                      iconConst.more,
                      color: colorConst.white,
                    ),
                    itemLabel: 'More'),
              ],
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
                log('current selected index $index');
                _pageController.jumpToPage(index);
              },
            )
          : null,
    );
  }
}
