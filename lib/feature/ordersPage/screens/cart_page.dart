import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/authPage/screens/signin_page.dart';
import 'package:meat_shop_app/feature/homePage/screens/HomePage.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/NavigationPage.dart';
import 'package:meat_shop_app/feature/ordersPage/repository/providers.dart';

import '../../../main.dart';
import '../../homePage/screens/meatList.dart';
import 'checkoutpage.dart';

class cartPage extends ConsumerStatefulWidget {
  const cartPage({super.key});
  @override
  ConsumerState<cartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<cartPage> {
  var totalPrice = 0;
addingTotal (){
  for(int i = 0; i < meatDetailCollection.length; i++){
    totalPrice = meatDetailCollection[i]["quantity"]*meatDetailCollection[i]["rate"];
    // ref.read(totalProviders.notifier).update((state) => totalPrice);
    print(totalPrice);
  }
}
  @override
  void initState() {
  addingTotal();
  // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding:  EdgeInsets.all(scrWidth*0.03),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                decoration: BoxDecoration(
                  color: colorConst.grey1,
                  borderRadius: BorderRadius.circular(scrWidth*0.08)
                ),
                child: Center(child: SvgPicture.asset(iconConst.backarrow))
            ),
          ),
        ),
        title: Text("My Cart",
        style: TextStyle(
          fontWeight: FontWeight.w800
        ),),
        actions: [
          InkWell(
              onTap: () {
                //print(meatDetailCollection);
                print(totalPrice);
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
          SizedBox(width: scrWidth*0.03,),
        ],
      ),
      bottomNavigationBar:addCart.isEmpty?SizedBox():
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
                  Text("₹ $totalPrice.00",
                    style: TextStyle(
                        color: colorConst.meroon,
                        fontSize: scrWidth*0.05,
                        fontWeight: FontWeight.w700
                    ),)
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => checkoutpage(),));
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
      body: Padding(
        padding:  EdgeInsets.all(scrWidth*0.028),
        child: addCart.isEmpty?
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
                  itemCount: addCart.length,
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
                              image: DecorationImage(image: NetworkImage(meatDetailCollection[index]["Image"]),fit: BoxFit.fill))
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
                                    Text(meatDetailCollection[index]["name"],
                                      style: TextStyle(
                                          fontSize: scrWidth*0.035,
                                          fontWeight: FontWeight.w700,
                                          color: colorConst.black
                                      ),),
                                    Text(meatDetailCollection[index]["ingredients"],style: TextStyle(
                                      fontSize: scrWidth*0.03
                                    ),),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text("${meatDetailCollection[index]["quantity"]} KG - ",
                                    style: TextStyle(
                                        fontSize: scrWidth*0.035,
                                        fontWeight: FontWeight.w700,
                                        color: colorConst.black
                                    ),),
                                  Text("₹ ${(meatDetailCollection[index]["rate"])*(meatDetailCollection[index]["quantity"])}",
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
                                        title: Text("Are you sure you want to remove this item from the Cart ?",style: TextStyle(
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
                                                meatDetailCollection.removeAt(index);
                                                addCart.removeAt(index);
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
                                      meatDetailCollection[index]["quantity"]<=1? 1
                                          :meatDetailCollection[index]["quantity"]--;
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
                                  Text(meatDetailCollection[index]["quantity"].toString(),
                                    style: TextStyle(
                                      fontSize: scrWidth*0.04,
                                      fontWeight: FontWeight.w600
                                    ),),
                                  SizedBox(width: scrWidth*0.015,),
                                  InkWell(
                                    onTap: () {
                                      meatDetailCollection[index]["quantity"]++;
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
                      Text("₹ $totalPrice.00",
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
                      Text("Discount",
                      style: TextStyle(
                        color: colorConst.black,
                        fontSize: scrWidth*0.04,
                        fontWeight: FontWeight.w500
                      ),),
                      Text("₹ 0.00",
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
                      Text("₹ 50.00",
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
