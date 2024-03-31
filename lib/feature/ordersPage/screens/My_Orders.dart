import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:meat_shop_app/Color_Page.dart';
// import 'package:meat_shop_app/Image_Page.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/main.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: colorConst.white,
        appBar: AppBar(
          backgroundColor: colorConst.white,
          elevation: 0,
          toolbarHeight: scrHeight * 0.1,
          // leadingWidth: w * 0.03,
          title: Padding(
            padding: EdgeInsets.all(scrWidth*0.03),
            child: Text("My Orders",
                style: TextStyle(
                    color: colorConst.black,
                    fontSize: scrWidth * 0.055,
                    fontWeight: FontWeight.w800)),
          ),
          actions: [
            SvgPicture.asset(iconConst.cart),
            SizedBox(width: scrWidth*0.025,),
            SvgPicture.asset(iconConst.notification),
            SizedBox(width: scrWidth*0.025,),
          ],
          bottom:
          TabBar(
            indicatorColor: colorConst.meroon,
            indicatorSize: TabBarIndicatorSize.tab,
            tabAlignment: TabAlignment.fill,
            indicatorWeight: 5.0,
            // indicatorWeight: ,
            tabs: [
              Padding(
                padding: EdgeInsets.only(left: scrWidth*0.03),
                child: Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Running",
                      style: TextStyle(
                        color: selectIndex == 0 ? colorConst.meroon :  colorConst.grey,
                        fontSize: scrWidth*0.045,
                        fontWeight: FontWeight.w800
                      ),)
                    ],
                  ),
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("History",style: TextStyle(
                    color: selectIndex == 0 ? colorConst.grey : colorConst.meroon,
                    fontSize: scrWidth*0.045,
                    fontWeight: FontWeight.w800
                ),)
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(scrWidth*0.04),
          child: TabBarView(
            children:[
              SizedBox(
                height: scrHeight * 0.73,
                width: scrWidth * 1,
                child: ListView.separated(
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: scrHeight * 0.12,
                      width: scrWidth * 1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(scrWidth*0.04),
                          border: Border.all(
                              color: colorConst.lightgrey.withOpacity(0.38)
                          ),
                          color: colorConst.white,
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                color: colorConst.black.withOpacity(0.15)
                            )
                          ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: scrWidth*0.095,
                            backgroundImage: AssetImage(
                                imageConst.logo
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Order ID: #23584",style: TextStyle(
                                  color: colorConst.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: scrWidth*0.038
                              ),),
                              Text("15 Mar 2024 - 11 PM",style: TextStyle(
                                  color: colorConst.textgrey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: scrWidth*0.035
                              ),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: scrHeight*0.03,
                                    width: scrWidth*0.27,
                                    decoration: BoxDecoration(
                                      color: colorConst.meroon,
                                      borderRadius: BorderRadius.circular(scrWidth*0.045),
                                    ),
                                    child: Center(
                                      child: Text("Track Order",
                                        style: TextStyle(
                                            color: colorConst.white,
                                            fontSize: scrWidth*0.03,
                                            fontWeight: FontWeight.w900
                                        ),),
                                    ),
                                  ),SizedBox(
                                    width: scrWidth*0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: scrWidth*0.02,
                                        backgroundColor: colorConst.orange,
                                      ),

                                      Text("  Processing",style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: scrWidth*0.033,
                                          color: colorConst.orange
                                      ),),
                                    ],
                                  ),

                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: scrHeight*0.02,);
                },
                ),
              ),
              SizedBox()
                    ]
          ),
        ),
      ),
    );
  }
}
