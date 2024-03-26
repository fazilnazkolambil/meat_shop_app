import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:meat_shop_app/Color_Page.dart';
// import 'package:meat_shop_app/Image_Page.dart';
import 'package:meat_shop_app/constant/color_const.dart';
import 'package:meat_shop_app/constant/image_const.dart';
import 'package:meat_shop_app/main.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: colorConst.white,
        appBar: AppBar(
          backgroundColor: colorConst.white,
          elevation: 0,
          toolbarHeight: h * 0.1,
          // leadingWidth: w * 0.03,
          title: Padding(
            padding: EdgeInsets.all(w*0.03),
            child: Text("My Orders",
                style: TextStyle(
                    color: colorConst.black,
                    fontSize: w * 0.055,
                    fontWeight: FontWeight.w800)),
          ),
          actions: [
            SvgPicture.asset(iconConst.cart),
            SizedBox(width: w*0.025,),
            SvgPicture.asset(iconConst.notification),
            SizedBox(width: w*0.025,),
          ],
          bottom:
          TabBar(
            indicatorColor: colorConst.meroon,
            indicatorSize: TabBarIndicatorSize.tab,
            // indicatorWeight: ,
            tabs: [
              Padding(
                padding: EdgeInsets.only(left: w*0.02),
                child: Tab(
                  text: "Running",
                ),
              ),
              Center(
                child: Tab(
                  text: "History",
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
