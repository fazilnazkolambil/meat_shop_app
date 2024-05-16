import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
// import 'package:meat_shop_app/Color_Page.dart';
// import 'package:meat_shop_app/Image_Page.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/NavigationPage.dart';
import 'package:meat_shop_app/feature/ordersPage/screens/orderdetails_page.dart';
import 'package:meat_shop_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../homePage/screens/meatList.dart';
import 'cart_page.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  int selectIndex = 0;
  List meatDetailCollection = [];

  Future <void> loadData()  async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString("cart");
    String? jsonString2 = prefs.getString("cart2");
    if (jsonString != null && jsonString2 != null){
      setState(() {
        meatDetailCollection = json.decode(jsonString);
        addCart = json.decode(jsonString2);
      });
    }
  }

  @override
  void initState() {
    loadData();
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: colorConst.white,
        appBar: AppBar(
          backgroundColor: colorConst.white,
          leading: SizedBox(),
          leadingWidth: 0,
          title: Text("My  Orders",
            style: TextStyle(
              fontWeight: FontWeight.w800,

            ),),
          actions: [
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => cartPage(),));
                },
                child: addCart.isEmpty?
                SvgPicture.asset(iconConst.cart):
                SizedBox(
                  height: scrWidth*0.08,
                  width: scrWidth*0.08,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: scrWidth*0.03,
                        left: scrWidth*0.03,
                        child: CircleAvatar(
                          backgroundColor: colorConst.meroon,
                          radius: scrWidth*0.025,
                          child: Center(
                            child: Text(addCart.length.toString(),style: TextStyle(
                                color: colorConst.white,
                                fontWeight: FontWeight.w600,
                                fontSize: scrWidth*0.03
                            ),),
                          ),
                        ),
                      ),
                      Positioned(
                          left: 0,
                          bottom: 0,
                          child: SvgPicture.asset(iconConst.cart,)),
                    ],
                  ),
                )),
            SizedBox(width: scrWidth*0.04,),
            SvgPicture.asset(iconConst.notification),
            SizedBox(width: scrWidth*0.04,),
          ],
          bottom:
          TabBar(
            indicatorColor: colorConst.meroon,
            indicatorSize: TabBarIndicatorSize.tab,
            //tabAlignment: TabAlignment.fill,
            indicatorWeight: 5.0,
            labelColor: colorConst.meroon,
            unselectedLabelColor: colorConst.grey,
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
                        // color: colorConst.meroon ,
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
                    // color: colorConst.grey ,
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
              SizedBox(),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("orderDetails").where("userId",isEqualTo:currentUserModel?.id ).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Lottie.asset(gifs.loadingGif);
                    }

                    var data = snapshot.data!.docs;
                    // List a=data[0]["orderHistory"];
                    return SizedBox(
                      height: scrHeight * 0.73,
                      width: scrWidth * 1,
                      child: ListView.separated(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => orderdetails(
                                data: data[index],
                                // id:data[index]["orderId"],
                              ),));
                            },
                            child: Container(
                              height: scrHeight * 0.12,
                              width: scrWidth * 1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      scrWidth * 0.04),
                                  border: Border.all(
                                      color: colorConst.lightgrey.withOpacity(
                                          0.38)
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
                                    radius: scrWidth * 0.095,
                                    backgroundImage: AssetImage(
                                        imageConst.logo
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("orderId:#${data[index]["orderId"]}", style: TextStyle(
                                        //"Order ID: #23584"
                                          color: colorConst.black,
                                          fontWeight: FontWeight.w800,
                                          fontSize: scrWidth * 0.038
                                      ),),
                                      Text('orderDate:', style: TextStyle(
                                          color: colorConst.textgrey,
                                          fontWeight: FontWeight.w400,
                                          fontSize: scrWidth * 0.035
                                      ),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: scrHeight * 0.03,
                                            width: scrWidth * 0.27,
                                            decoration: BoxDecoration(
                                              color: colorConst.meroon,
                                              borderRadius: BorderRadius.circular(
                                                  scrWidth * 0.045),
                                            ),
                                            child: Center(
                                              child: Text("Track Order",
                                                style: TextStyle(
                                                    color: colorConst.white,
                                                    fontSize: scrWidth * 0.03,
                                                    fontWeight: FontWeight.w900
                                                ),),
                                            ),
                                          ), SizedBox(
                                            width: scrWidth * 0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              CircleAvatar(
                                                radius: scrWidth * 0.02,
                                                backgroundColor: colorConst
                                                    .orange,
                                              ),

                                              Text(
                                                "  Processing", style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: scrWidth * 0.033,
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
                            ),
                          );
                        }, separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: scrHeight * 0.02,);
                      },
                      ),
                    );
                  }
    ),
            ]
          ),
        ),
      ),
    );
  }
}



