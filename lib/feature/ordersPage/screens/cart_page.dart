import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/authPage/screens/signin_page.dart';
import 'package:meat_shop_app/feature/homePage/screens/HomePage.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/NavigationPage.dart';
import 'package:meat_shop_app/feature/ordersPage/repository/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../authPage/screens/info_page.dart';
import '../../homePage/screens/meatList.dart';
import 'checkoutpage.dart';

class cartPage extends ConsumerStatefulWidget {
  const cartPage({super.key});
  @override
  ConsumerState<cartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<cartPage> {
  var a=[];
  int total = 0;
  int totalPrice = 0;
  int discount = 0;
  int shippingCharge = 50;
  addingTotal() {
    total = 0;
    for (int i = 0; i < cartMeats.length; i++){
      total = cartMeats[i]["quantity"] * cartMeats[i]["rate"] + total;
      totalPrice = total - discount + shippingCharge;
    }
  }
  List meatDetailCollection = [];
  List cartMeats = [];
  bool loading = false;
  Future <void> loadData()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString("cart");
    String? jsonString2 = prefs.getString("cart2");
    if (jsonString != null  && jsonString2 != null) {
        meatDetailCollection = json.decode(jsonString);
        addCart = json.decode(jsonString2);
        loading = true;
        setState(() {

        });
       for(int i = 0; i < meatDetailCollection.length; i++) {
         String meatCategory = meatDetailCollection[i]["category"];
         String meatType = meatDetailCollection[i]["type"];
         String meatId = meatDetailCollection[i]["id"];
         var data = await FirebaseFirestore.instance.collection("meatTypes")
             .doc(meatType)
             .collection(meatType).doc(meatCategory)
             .collection(meatType).doc(meatId)
             .get();
         if (data.exists) {
           cartMeats.add({
             "Image": data["Image"],
             "id": data["id"],
             "name": data["name"],
             "rate": data["rate"],
             "ingredients": data["ingredients"],
             "quantity": 1,
           });
         } else {
           meatDetailCollection.removeAt(i);
           addCart.removeAt(i);
           saveData();
         }
         loading = false;
         setState(() {

         });
       }
      }
    addingTotal();
   }
  Future <void> saveData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(meatDetailCollection);
    String jsonString2 = json.encode(addCart);
    prefs.setString("cart", jsonString);
    prefs.setString("cart2", jsonString2);
  }

  @override
  void initState() {
    loadData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return loading?
        Scaffold(
          backgroundColor: colorConst.black.withOpacity(0.3),
          body: Center(child: SizedBox(
            height: scrHeight*0.5,
              width: scrWidth*0.8,
              child: Lottie.asset(gifs.loadingGif))),
        )
      :Scaffold(
      backgroundColor: colorConst.white,
      appBar: AppBar(
        leading: Padding(
          padding:EdgeInsets.all(scrWidth*0.03),
          child: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => NavigationPage(),), (route) => false);
            },
            child: CircleAvatar(
                backgroundColor: colorConst.grey1,
                child: Center(child: SvgPicture.asset(iconConst.backarrow))),
          ),
        ),
        title: Text("My Cart",
          style: TextStyle(
              fontWeight: FontWeight.w800
          ),),
        actions: [
          GestureDetector(
              onTap: () async {
                print(meatDetailCollection);
                print(cartMeats);
                print(addCart);
                //print(totalPrice.last);
              },
              child: meatDetailCollection.isEmpty?
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
                          child: Text(meatDetailCollection.length.toString(),style: TextStyle(
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
          SizedBox(width: scrWidth*0.03,),
        ],
      ),
      bottomNavigationBar:meatDetailCollection.isEmpty?SizedBox():
      Container(
        height: scrWidth*0.37,
        decoration: BoxDecoration(
            color: colorConst.white,
            borderRadius: BorderRadius.circular(scrWidth*0.07),
            boxShadow: [
              BoxShadow(
                  color: colorConst.black.withOpacity(0.2),
                  blurRadius: 54,
                  offset: Offset(0, -16),
                  spreadRadius: 0
              )
            ]
        ),
        child: Padding(
          padding:  EdgeInsets.all(scrWidth*0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Subtotal",
                    style: TextStyle(
                        color: colorConst.black,
                        fontSize: scrWidth*0.05,
                        fontWeight: FontWeight.w700
                    ),),
                  Text("₹ $totalPrice .00",
                    style: TextStyle(
                        color: colorConst.meroon,
                        fontSize: scrWidth*0.05,
                        fontWeight: FontWeight.w700
                    ),)
                ],
              ),
              InkWell(
                onTap: () {
                  if(loginId!.isNotEmpty){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => checkoutpage(price: "$total",discount: '$discount',shippingCharge: '$shippingCharge',subtotal: '$totalPrice',),));
                  }else{
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return BottomSheet(
                          onClosing: () {

                          },
                          builder: (context) {
                            return Container(
                              height: scrHeight*0.2,
                              width: scrWidth*1,
                              margin: EdgeInsets.all(scrWidth*0.05),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Let's get you in!",style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: scrWidth*0.05
                                  ),),
                                  Text("In just a minute, you can access all our offers, services and more.",
                                    textAlign: TextAlign.center,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => infoPage(path: 'cartPage',),));
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
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => signinPage(path: 'cartPage',),));
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
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );

                  }

                },
                child: Container(
                  height: scrWidth*0.15,
                  width: scrWidth*0.9,
                  decoration: BoxDecoration(
                    color: colorConst.meroon,
                    borderRadius: BorderRadius.circular(scrWidth*0.05),
                  ),
                  child: Center(child: Text("Proceed  To checkout",
                    style: TextStyle(
                        color: colorConst.white
                    ),)),
                ),
              )
            ],
          ),
        ),
      ),
      body:Padding(
        padding:  EdgeInsets.all(scrWidth*0.028),
        child: meatDetailCollection.isEmpty?
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Lottie.asset(gifs.emptyCart),
            Text("There's nothing yet in you Cart!",style: TextStyle(
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
                child: Center(child: Text("Add Items",
                  style: TextStyle(
                      color: colorConst.white
                  ),)),
              ),
            )
          ],
        )
            : SingleChildScrollView(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: cartMeats.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: scrWidth*0.33,
                    decoration: BoxDecoration(
                        color: colorConst.white,
                        borderRadius: BorderRadius.circular(scrWidth*0.04),
                        border: Border.all(
                            width: scrWidth*0.0003,
                            color: colorConst.black.withOpacity(0.38)
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: colorConst.black.withOpacity(0.1),
                              blurRadius: 14,
                              offset: Offset(0, 4),
                              spreadRadius:0
                          )
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: scrWidth*0.02,),
                        Container(
                            height: scrWidth*0.27,
                            width: scrWidth*0.27,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(scrWidth*0.04),
                                border: Border.all(
                                    width: scrWidth*0.0003,
                                    color: colorConst.black.withOpacity(0.38)
                                ),
                                image: DecorationImage(image: NetworkImage(cartMeats[index]["Image"]),fit: BoxFit.fill))
                        ),
                        SizedBox(width: scrWidth*0.02,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: scrWidth*0.4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cartMeats[index]["name"],
                                    style: TextStyle(
                                        fontSize: scrWidth*0.035,
                                        fontWeight: FontWeight.w700,
                                        color: colorConst.black
                                    ),),
                                  Text(cartMeats[index]["ingredients"],style: TextStyle(
                                      fontSize: scrWidth*0.03
                                  ),),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text("${cartMeats[index]["quantity"]} KG - ",
                                  style: TextStyle(
                                      fontSize: scrWidth*0.035,
                                      fontWeight: FontWeight.w700,
                                      color: colorConst.black
                                  ),),
                                Text("₹ ${(cartMeats[index]["rate"])*(cartMeats[index]["quantity"])}",
                                  style: TextStyle(
                                      fontSize: scrWidth*0.035,
                                      fontWeight: FontWeight.w700,
                                      color: colorConst.meroon
                                  ),),
                              ],
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Are you sure you want to remove this item from the Cart ?",
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
                                            onTap : () {
                                              cartMeats.removeAt(index);
                                              meatDetailCollection.removeAt(index);
                                              addCart.removeAt(index);
                                              saveData();
                                              addingTotal();
                                              Navigator.pop(context);
                                              setState(() {

                                              });
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
                              child: Container(
                                  height: scrWidth*0.1,
                                  width: scrWidth*0.1,
                                  decoration: BoxDecoration(
                                      color: colorConst.white,
                                      borderRadius: BorderRadius.circular(scrWidth*0.05),
                                      boxShadow: [
                                        BoxShadow(
                                            color: colorConst.black.withOpacity(0.1),
                                            blurRadius: 14,
                                            offset: Offset(0, 4),
                                            spreadRadius: 0
                                        )
                                      ]
                                  ),
                                  child: Center(child: SvgPicture.asset(iconConst.delete))
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    cartMeats[index]["quantity"]<=1? 1
                                        :cartMeats[index]["quantity"]--;
                                    cartMeats[index]["rate"] * cartMeats[index]["quantity"];
                                    addingTotal();
                                    setState(() {

                                    });
                                  },
                                  child: Container(
                                    height:scrWidth*0.065,
                                    width:scrWidth*0.065,
                                    decoration: BoxDecoration(
                                        color:colorConst.grey1,
                                        borderRadius: BorderRadius.circular(scrWidth*0.06),
                                        border: Border.all(
                                            width: scrWidth*0.0003,
                                            color: colorConst.black.withOpacity(0.38)
                                        )
                                    ),
                                    child:Icon(Icons.remove,
                                        size:scrWidth*0.04),
                                  ),
                                ),
                                SizedBox(width: scrWidth*0.015,),
                                Text(cartMeats[index]["quantity"].toString(),
                                  style: TextStyle(
                                      fontSize: scrWidth*0.04,
                                      fontWeight: FontWeight.w600
                                  ),),
                                SizedBox(width: scrWidth*0.015,),
                                InkWell(
                                  onTap: () {
                                    cartMeats[index]["quantity"]++;
                                    cartMeats[index]["rate"] * cartMeats[index]["quantity"];
                                    addingTotal();
                                    setState(() {

                                    });
                                  },
                                  child: Container(
                                    height:scrWidth*0.065,
                                    width:scrWidth*0.065,
                                    decoration: BoxDecoration(
                                        color:colorConst.grey1,
                                        borderRadius: BorderRadius.circular(scrWidth*0.06),
                                        border: Border.all(
                                            width: scrWidth*0.0003,
                                            color: colorConst.black.withOpacity(0.38)
                                        )
                                    ),
                                    child:Center(child: Icon(Icons.add,
                                        size:scrWidth*0.04)),
                                  ),
                                )
                              ],

                            ),
                          ],
                        ),
                        SizedBox(width: scrWidth*0.02,),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: scrWidth*0.03,);
                },
              ),
              SizedBox(height: scrWidth*0.04,),
              Text("Order Summary",
                style:TextStyle(
                    fontSize:scrWidth*0.05,
                    fontWeight:FontWeight.w700,
                    color: colorConst.meroon
                ),),
              SizedBox(height: scrWidth*0.02,),
              Text("Additional Note",
                style:TextStyle(
                    fontSize:scrWidth*0.04,
                    fontWeight:FontWeight.w700,
                    color: colorConst.black
                ),),
              SizedBox(height: scrWidth*0.02,),
              Container(
                height: scrWidth*0.3,
                decoration: BoxDecoration(
                    color: colorConst.white,
                    borderRadius: BorderRadius.circular(scrWidth*0.04),
                    border: Border.all(
                        width: scrWidth*0.0003,
                        color: colorConst.black.withOpacity(0.38)
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: colorConst.black.withOpacity(0.1),
                          blurRadius: 14,
                          offset: Offset(0, 4),
                          spreadRadius: 0
                      )
                    ]
                ),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  maxLines: null,
                  cursorColor: colorConst.grey,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: scrWidth*0.05,right: scrWidth*0.05),
                      border:InputBorder.none,
                      hintText: "Any instruction regarding cuts",
                      hintStyle: TextStyle(
                          fontSize: scrWidth*0.04
                      )
                  ),
                ),
              ),
              SizedBox(height: scrWidth*0.05,),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Item Price",
                        style: TextStyle(
                            color: colorConst.black,
                            fontSize: scrWidth*0.04,
                            fontWeight: FontWeight.w500
                        ),),
                      Text("₹ $total.00",
                        style: TextStyle(
                            color: colorConst.black,
                            fontSize: scrWidth*0.04,
                            fontWeight: FontWeight.w600
                        ),)
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Discount",
                        style: TextStyle(
                            color: colorConst.black,
                            fontSize: scrWidth*0.04,
                            fontWeight: FontWeight.w500
                        ),),
                      Text("₹ $discount.00",
                        style: TextStyle(
                            color: colorConst.black,
                            fontSize: scrWidth*0.04,
                            fontWeight: FontWeight.w500
                        ),)
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Shipping Charge",
                        style: TextStyle(
                            color: colorConst.black,
                            fontSize: scrWidth*0.04,
                            fontWeight: FontWeight.w500
                        ),),
                      Text("₹ $shippingCharge.00",
                        style: TextStyle(
                            color: colorConst.black,
                            fontSize: scrWidth*0.04,
                            fontWeight: FontWeight.w500
                        ),)
                    ],
                  ),
                  SizedBox(height: scrWidth*0.08,),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}