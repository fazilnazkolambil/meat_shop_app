

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
// import 'package:meat_shop_app/Color_Page.dart';
// import 'package:meat_shop_app/Image_Page.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/NavigationPage.dart';
import 'package:meat_shop_app/feature/ordersPage/screens/orderdetails_page.dart';
import 'package:meat_shop_app/feature/ordersPage/screens/ordertracking.dart';
import 'package:meat_shop_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../authPage/screens/info_page.dart';
import '../../authPage/screens/signin_page.dart';
import '../../homePage/screens/meatList.dart';
import 'cart_page.dart';

class OrderList extends StatelessWidget {
  final List data;
  final String status;
  const OrderList({super.key, required this.data, required this.status});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return data[index]["orderStatus"] == status?
          InkWell(
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
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ordertracking(data: data,),));
                          },
                          child: Container(
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
        ):
            SizedBox();
      }, separatorBuilder: (BuildContext context, int index) {
      return SizedBox(height: scrHeight * 0.02,);
    },
    );
  }
}

final orderStream = StreamProvider((ref) {
  return FirebaseFirestore.instance.collection("orderDetails").where("userId",isEqualTo:loginId ).snapshots();
});

class MyOrders extends ConsumerStatefulWidget {
  const MyOrders({super.key});

  @override
  ConsumerState<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends ConsumerState<MyOrders> {
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
          bottom:loginId.isEmpty?TabBar(tabs: [SizedBox(),SizedBox()],):
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
          child: loginId.isEmpty?
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Lottie.asset(gifs.login),
              Text("Please Login to view your Order history and access all offers and services!",textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: scrWidth*0.04
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => infoPage(path: '',),));
                    },
                    child: Container(
                      height: scrHeight*0.05,
                      width: scrWidth*0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(scrWidth*0.03),
                          border: Border.all(color: colorConst.meroon)
                      ),
                      child: Center(child: Text("Sign Up"),),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => signinPage(path: '',),));
                    },
                    child: Container(
                      height: scrHeight*0.05,
                      width: scrWidth*0.4,
                      decoration: BoxDecoration(
                          color: colorConst.meroon,
                          borderRadius: BorderRadius.circular(scrWidth*0.03),
                          border: Border.all(color: colorConst.meroon)
                      ),
                      child: Center(child: Text("Log In",style: TextStyle(
                          color: colorConst.white
                      ),),),
                    ),
                  ),
                ],
              ),
              SizedBox(height: scrHeight*0.01,)
            ],
          ):

          ref.watch(orderStream).when(
            data: (data){

              return data.docs.isEmpty?

              SizedBox(
                height: scrHeight*0.7,
                width: scrWidth*1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Lottie.asset(gifs.emptyCart),
                    Text("Your order list is Empty!",style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: scrWidth*0.04
                    )),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => NavigationPage(),), (route) => false);
                      },
                      child: Container(
                        height: scrWidth*0.15,
                        width: scrWidth*0.9,
                        decoration: BoxDecoration(
                          color: colorConst.meroon,
                          borderRadius: BorderRadius.circular(scrWidth*0.05),
                        ),
                        child: Center(child: Text("Order Now",
                          style: TextStyle(
                              color: colorConst.white
                          ),)),
                      ),
                    )

                  ],
                ),
              ):
              TabBarView(children: [
                OrderList(data: data.docs, status: 'Ordered'),
                OrderList(data: data.docs, status: "Delivered"),
              ]);
            }, error: (error, stackTrace) => Text(error.toString()),
            loading: () => Center(child: Lottie.asset(gifs.loadingGif),),
          )
          // TabBarView(
          //     children:[
          //
          //       //
          //       // StreamBuilder<QuerySnapshot>(
          //       //     stream: .snapshots(),
          //       //     builder: (context, snapshot) {
          //       //       if (!snapshot.hasData) {
          //       //         return Lottie.asset(gifs.loadingGif);
          //       //       }
          //       //
          //       //       var data = snapshot.data!.docs;
          //       //       // List a=data[0]["orderHistory"];
          //       //       return SizedBox(
          //       //         height: scrHeight * 0.73,
          //       //         width: scrWidth * 1,
          //       //         child: OrderList(data: data),
          //       //       );
          //       //     }
          //       // ),
          //       // SizedBox(),
          //     ]
          // ),
        ),
      ),
    );
  }
}
