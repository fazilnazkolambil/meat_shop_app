import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
// import 'package:meat_shop_app/Image_Page.dart';
// import 'package:meat_shop_app/constant/Color_Page.dart';

import '../../../main.dart';
import '../../favoritePage/screens/favourite_page.dart';
import '../../homePage/screens/HomePage.dart';
import '../../morePage/screens/more_page.dart';
import '../../ordersPage/screens/My_Orders.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

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

  @override
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
              showTopRadius: true,
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
              durationInMilliSeconds: 300,
              kIconSize: scrWidth*0.06,
              kBottomRadius: scrWidth*0.03,
              bottomBarItems: [
                BottomBarItem(
                  inActiveItem: SvgPicture.asset(
                    iconConst.home,
                    color: colorConst.bottomcolor.withOpacity(0.50),
                  ),
                  activeItem: SvgPicture.asset(
                    iconConst.home,
                    color: colorConst.white,
                  ),
                  itemLabel: 'Home',
                ),
                BottomBarItem(
                  inActiveItem: SvgPicture.asset(
                    iconConst.cart,
                    color: colorConst.bottomcolor.withOpacity(0.50),
                  ),
                  activeItem: SvgPicture.asset(
                    iconConst.cart,
                    color: colorConst.white,
                  ),
                  itemLabel: 'orders',
                ),
                BottomBarItem(
                  inActiveItem: SvgPicture.asset(
                    iconConst.Favourite1,
                    //color: colorConst.bottomcolor.withOpacity(0.50),
                  ),
                  activeItem: SvgPicture.asset(
                    iconConst.Favourite1,
                    color: colorConst.white,
                  ),
                  itemLabel: 'Favourite',
                ),
                BottomBarItem(
                    inActiveItem: SvgPicture.asset(
                      iconConst.more,
                      color: colorConst.bottomcolor.withOpacity(0.50),
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
