import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meat_shop_app/constant/color_const.dart';
// import 'package:meat_shop_app/Image_Page.dart';
// import 'package:meat_shop_app/constant/Color_Page.dart';

import 'main.dart';

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
    // home(),
    // Page2(),
    // Page3(),
    // Page4(),
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
              showTopRadius: false,
              notchBottomBarController: _controller,
              color: Colors.white,
              showLabel: true,
              itemLabelStyle: TextStyle(color: Colors.black, fontSize: 16.0),
              shadowElevation: 1,
              notchColor: colorConst.meroon,
              removeMargins: false,
              bottomBarWidth: w * 1,
              showShadow: false,
              durationInMilliSeconds: 300,
              kIconSize: 24.0,
              kBottomRadius: 28.0,
              elevation: 1,
              bottomBarItems: [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home,
                    color: Colors.deepOrange,

                  ),
                  activeItem: Icon(
                    Icons.star,
                    color: Colors.blueAccent,
                  ),
                  itemLabel: 'Page 1',

                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.star,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.star,
                    color: Colors.blueAccent,
                  ),
                  itemLabel: 'Page 2',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.settings,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.settings,
                    color: Colors.pink,
                  ),
                  itemLabel: 'Page 3',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.person,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.person,
                    color: Colors.yellow,
                  ),
                  itemLabel: 'Page 4'
                ),
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
