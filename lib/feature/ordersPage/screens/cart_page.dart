import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/authPage/screens/signin_page.dart';
import 'package:meat_shop_app/feature/homePage/repository/bottomSheet.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/HomePage.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/NavigationPage.dart';
import 'package:meat_shop_app/feature/ordersPage/repository/providers.dart';
import 'package:meat_shop_app/models/cartMeatModel.dart';
import 'package:meat_shop_app/models/orderDetailsModel.dart';
import 'package:meat_shop_app/models/userModel.dart';
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
  TextEditingController notesController=TextEditingController();

  double total = 0;
  double totalPrice = 0;
  double discount = 0;
  double shippingCharge = 50;
  addingTotal() {
    total = 0;
    for (int i = 0; i < cartMeats.length; i++){
      total = cartMeats[i]['qty'] * cartMeats[i]['rate'] + total;
      totalPrice = total - discount + shippingCharge;
    }
  }
  List meatDetailCollection = [];
  List cartMeats = [];
  // List orderHistory=[];
  bool loading = false;
  bool? loggedIn;
  Future <void> loadData()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool('LoggedIn') ?? false;
    String? jsonString = prefs.getString("cart");
    String? jsonString2 = prefs.getString("cart2");
    if (jsonString != null  && jsonString2 != null) {
        meatDetailCollection = json.decode(jsonString);
        addCart = json.decode(jsonString2);
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
           // cartMeats.add(CartMeatModel(
           //     name: data['name'],
           //     image: data['Image'],
           //     description: data['description'],
           //     category: data['category'],
           //     id: data['id'],
           //     ingredients: data['ingredients'],
           //     type: data['type'],
           //     quantity: (data['quantity']).toDouble(),
           //     qty: (data['qty']).toDouble(),
           //     rate: (data['rate']).toDouble()));
           cartMeats.add({
             "image": data["Image"],
             "id": data["id"],
             "name": data["name"],
             "rate": data["rate"],
             "ingredients": data["ingredients"],
             "qty": 0.5,
           });
         } else {
           meatDetailCollection.removeAt(i);
           addCart.removeAt(i);
           saveData();
         }
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
    // final count = ref.watch(counterProvider);
    return
      // loading?
      //   Scaffold(
      //     backgroundColor: colorConst.black.withOpacity(0.3),
      //     body: Center(child: SizedBox(
      //       height: scrHeight*0.5,
      //         width: scrWidth*0.8,
      //         child: Lottie.asset(gifs.loadingGif))),
      //   ):
      Scaffold(
      backgroundColor: colorConst.white,
      appBar: AppBar(
        surfaceTintColor: colorConst.white,
        backgroundColor: colorConst.white,
        leading: Padding(
          padding:EdgeInsets.all(scrWidth*0.03),
          child: GestureDetector(
            onTap: () {
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => NavigationPage(),), (route) => false);
               //Navigator.pop(context);
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
              onTap: () async {},
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
                        fontWeight: FontWeight.w600
                    ),),
                  Text("₹ $totalPrice",
                    style: TextStyle(
                        color: colorConst.meroon,
                        fontSize: scrWidth*0.05,
                        fontWeight: FontWeight.w600
                    ),)
                ],
              ),
              InkWell(
                onTap: () {
                  // print(total);
                  // print(discount);
                  // print(shippingCharge);
                  // print(totalPrice);
                  if(loggedIn == true)
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage(
                      price: total,
                      discount: discount,
                      shippingCharge: shippingCharge,
                      subtotal: totalPrice,
                      cartMeat: cartMeats,
                      notes: notesController.text,
                    )));
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
                                image: DecorationImage(image: NetworkImage(cartMeats[index]['image']),fit: BoxFit.fill))
                        ),
                        SizedBox(width: scrWidth*0.02,),
                        Stack(
                          children: [
                            SizedBox(
                              width: scrWidth*0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(cartMeats[index]['name'],
                                    style: TextStyle(
                                        fontSize: scrWidth*0.035,
                                        fontWeight: FontWeight.w700,
                                        color: colorConst.black
                                    ),),
                                  Text(cartMeats[index]['ingredients'],style: TextStyle(
                                      fontSize: scrWidth*0.03
                                  ),),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text("${cartMeats[index]['qty']} KG - ",
                                        style: TextStyle(
                                            fontSize: scrWidth*0.035,
                                            fontWeight: FontWeight.w700,
                                            color: colorConst.black
                                        ),),
                                      Text("₹ ${(cartMeats[index]['rate'])*(cartMeats[index]['qty'])}",
                                        style: TextStyle(
                                            fontSize: scrWidth*0.035,
                                            fontWeight: FontWeight.w700,
                                            color: colorConst.meroon
                                        ),),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: InkWell(
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
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    cartMeats[index]['qty'] <= 0.5?cartMeats[index]['qty'] = 0.5:
                                    cartMeats[index]['qty'] = cartMeats[index]['qty'] - 0.5;
                                    addingTotal();
                                    setState(() {

                                    });
                                    // count.qty <= 0.5 ? 0.5:
                                    // ref.read(counterProvider.notifier).updatecount(count.qty - 0.5);
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
                                Text(cartMeats[index]['qty'].toString(),
                                  style: TextStyle(
                                      fontSize: scrWidth*0.035,
                                      fontWeight: FontWeight.w600
                                  ),),
                                SizedBox(width: scrWidth*0.015,),
                                InkWell(
                                  onTap: () {
                                    //ref.read(counterProvider.notifier).updatecount(count.qty + 0.5);
                                    cartMeats[index]['qty'] = cartMeats[index]['qty'] + 0.5;
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
                            )
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
                  controller: notesController,
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
                      Text("₹ $total",
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
                      Text("₹ $discount",
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
                      Text("₹ $shippingCharge",
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