import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';

import '../../../main.dart';
import 'orderconfirm_page.dart';

class checkoutpage extends StatefulWidget {
  const checkoutpage({super.key});

  @override
  State<checkoutpage> createState() => _checkoutpageState();
}

class _checkoutpageState extends State<checkoutpage> {
  String pymnt="";
  String labelas="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
      Container(
        height: scrWidth*0.33,
        width: scrWidth*1.1,
        decoration: BoxDecoration(
            color: colorConst.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(scrWidth*0.07),
                topRight: Radius.circular(scrWidth*0.07)),
            boxShadow: [BoxShadow(
                color: colorConst.grey,
                spreadRadius: scrWidth*0.02,
                offset: Offset(0, 3),
                blurRadius: scrWidth*0.03
            )]
          // color: Colors.grey
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: scrWidth*0.9,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Amount",style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: scrWidth*0.035),
                        ),
                        Text("KWD 12.000",style: TextStyle(
                            color: colorConst.meroon,
                            fontWeight: FontWeight.normal,fontSize: scrWidth*0.035)
                        )
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => orderconfirm(),));
                },
                child: Container(
                  height: scrWidth*0.13,
                  width: scrWidth*0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(scrWidth*0.04),
                      color: colorConst.meroon
                  ),
                  child: Center(child: Text("Confirm Order",style: TextStyle(color: colorConst.white,fontWeight: FontWeight.bold,fontSize: scrWidth*0.035),)),
                ),
              )
            ]

        ),
      ),
      appBar: AppBar(
        leading: Padding(
          padding:  EdgeInsets.all(scrWidth*0.03),
          child: Container(
              decoration: BoxDecoration(
                  color: colorConst.grey1,
                  borderRadius: BorderRadius.circular(scrWidth*0.08)
              ),
              child: Center(child: SvgPicture.asset(iconConst.backarrow))
          ),
        ),
        title: Text("Checkout",
          style: TextStyle(
              fontWeight: FontWeight.w600
          ),),
        actions: [
          Container(child: SvgPicture.asset(iconConst.cart)),
          SizedBox(width: scrWidth*0.04,),
          Container(child: SvgPicture.asset(iconConst.notification)),
          SizedBox(width: scrWidth*0.03,),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: scrWidth*0.18,
              width: scrWidth*0.9,
              decoration: BoxDecoration(
                  color: colorConst.grey1,
                  borderRadius: BorderRadius.circular(scrWidth*0.07)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Select Saved Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: scrWidth*0.035),),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        enableDrag: true,
                        elevation: 20,
                        scrollControlDisabledMaxHeightRatio: Checkbox.width,
                        // showDragHandle: true,
                        backgroundColor: colorConst.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(scrWidth*0.07,),
                            topRight: Radius.circular(scrWidth*0.07),
                          ),
                        ),
                        builder: (context) {
                          return Container(
                            height: scrWidth*1.88,
                            width: scrWidth*1,
                            child: Padding(
                              padding:  EdgeInsets.all(scrWidth*0.03),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Add  New Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: scrWidth*0.035)
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                          child: Icon(Icons.close)
                                      )
                                    ],
                                  ),
                                  Container(
                                    child: Image(image: AssetImage(imageConst.map),),
                                  ),
                                  Row(
                                    children: [
                                      Text("Label As",style: TextStyle(fontWeight: FontWeight.bold,fontSize: scrWidth*0.035)
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      RadioMenuButton(
                                          value: "home",
                                          groupValue: labelas,
                                          onChanged: (value) {
                                            setState(() {
                                              labelas=value!;
                                            });

                                          },
                                          child:  Text("Home",style: TextStyle(
                                              fontWeight: FontWeight.normal,fontSize: scrWidth*0.035),
                                          )
                                      ),
                                      RadioMenuButton(
                                          value: "office",
                                          groupValue: labelas,
                                          onChanged: (value) {
                                            setState(() {
                                              labelas=value!;
                                            });

                                          },
                                          child:  Text("Office",style: TextStyle(
                                              fontWeight: FontWeight.normal,fontSize: scrWidth*0.035),
                                          )
                                      ),
                                  ],
                                  ),
                                  Container(
                                    height: scrWidth*0.12,
                                    width: scrWidth*1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(scrWidth*0.03),
                                      border: Border.all(width: scrWidth*0.005,color: colorConst.grey)
                                    ),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Container(
                                      height: scrWidth*0.12,
                                      width: scrWidth*0.4,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(scrWidth*0.03),
                                          border: Border.all(width: scrWidth*0.005,color: colorConst.grey)
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: scrWidth*0.12,
                                      width: scrWidth*0.5,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(scrWidth*0.03),
                                          border: Border.all(width: scrWidth*0.005,color: colorConst.grey)
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none
                                        ),
                                      ),
                                    ),
                                  ],),
                                  Container(
                                    height: scrWidth*0.12,
                                    width: scrWidth*1,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(scrWidth*0.03),
                                        border: Border.all(width: scrWidth*0.005,color: colorConst.grey)
                                    ),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: scrWidth*0.12,
                                        width: scrWidth*0.4,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(scrWidth*0.03),
                                            border: Border.all(width: scrWidth*0.005,color: colorConst.grey)
                                        ),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: scrWidth*0.12,
                                        width: scrWidth*0.5,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(scrWidth*0.03),
                                            border: Border.all(width: scrWidth*0.005,color: colorConst.grey)
                                        ),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none
                                          ),
                                        ),
                                      ),
                                    ],),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: scrWidth*0.13,
                                      width: scrWidth*0.9,
                                      decoration: BoxDecoration(
                                        color: colorConst.meroon,
                                        borderRadius: BorderRadius.circular(scrWidth*0.05),
                                      ),
                                      child: Center(child: Text("Save Address",
                                        style: TextStyle(
                                            color: colorConst.white
                                        ),)),
                                    ),
                                  )
                                  
                                ],
                              ),
                            ),
                          );
                        },);
                    },
                    child: Container(
                      height: scrWidth*0.08,
                      width: scrWidth*0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(scrWidth*0.07),
                          color: colorConst.meroon
                      ),
                      child: Center(child: Text("Add New",style: TextStyle(color: colorConst.white,fontWeight: FontWeight.bold,fontSize: scrWidth*0.035),)),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: scrWidth*0.18,
              width: scrWidth*0.9,
              decoration: BoxDecoration(
                  color: colorConst.grey1,
                  borderRadius: BorderRadius.circular(scrWidth*0.07)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Select Delivery Date & Time",style: TextStyle(fontWeight: FontWeight.bold,fontSize: scrWidth*0.035),),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(scrWidth*0.05)),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: scrWidth*0.3,),
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(Icons.close)),
                              ],
                            ),

                            content: Container(
                              height: scrWidth*1,
                              width: scrWidth*0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(scrWidth*0.06),

                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                ],
                              ),
                            ),
                          );
                        },);
                    },
                    child: Container(
                      height: scrWidth*0.09,
                      width: scrWidth*0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(scrWidth*0.12),
                          color: colorConst.meroon
                      ),
                      child: Center(child: Icon(Icons.calendar_month_outlined,color: colorConst.white,)),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: scrWidth*0.54,
              width: scrWidth*0.9,
              decoration: BoxDecoration(
                  color: colorConst.grey1,
                  borderRadius: BorderRadius.circular(scrWidth*0.07)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Select Payment Method",style: TextStyle(fontWeight: FontWeight.bold,fontSize: scrWidth*0.035),),
                  Column(
                    children: [
                      RadioMenuButton(
                          value: "cashondelivery",
                          groupValue: pymnt,
                          onChanged: (value) {
                            setState(() {
                              pymnt=value!;
                            });

                          },
                          child:  Text("Cash On Delivery",style: TextStyle(
                              fontWeight: FontWeight.normal,fontSize: scrWidth*0.035),
                          )
                      ),
                      RadioMenuButton(
                          value: "creditcard",
                          groupValue: pymnt,
                          onChanged: (value) {
                            setState(() {
                              pymnt=value!;
                            });

                          },
                          child:  Text("Credit Card",style: TextStyle(
                              fontWeight: FontWeight.normal,fontSize: scrWidth*0.035),
                          )
                      ),
                      RadioMenuButton(
                          value: "debitcaard",
                          groupValue: pymnt,
                          onChanged: (value) {
                            setState(() {
                              pymnt=value!;
                            });

                          },
                          child:  Text("Debit Card",style: TextStyle(
                              fontWeight: FontWeight.normal,fontSize: scrWidth*0.035),
                          )
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: scrWidth*0.35,
              width: scrWidth*0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        "Order Summary",style: TextStyle(
                          color: colorConst.meroon,fontWeight: FontWeight.normal,fontSize: scrWidth*0.035),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Item Price",style: TextStyle(
                          fontWeight: FontWeight.normal,fontSize: scrWidth*0.035),
                      ),
                      Text("KWD 11.000",style: TextStyle(
                          fontWeight: FontWeight.normal,fontSize: scrWidth*0.035)
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Discount",style: TextStyle(
                          fontWeight: FontWeight.normal,fontSize: scrWidth*0.035),
                      ),
                      Text("KWD 0.000",style: TextStyle(
                          fontWeight: FontWeight.normal,fontSize: scrWidth*0.035)
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Shipping Charge",style: TextStyle(
                          fontWeight: FontWeight.normal,fontSize: scrWidth*0.035),
                      ),
                      Text("KWD 1.000",style: TextStyle(
                          fontWeight: FontWeight.normal,fontSize: scrWidth*0.035)
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: scrWidth*0.88,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("I have read and agreed with "),
                      Text("Privacy Policy ",style: TextStyle(
                          color: colorConst.meroon,fontWeight: FontWeight.bold,fontSize: scrWidth*0.035
                      ),),
                    ],
                  ),
                  Row(
                    children: [
                      Text(" and"),
                      Text(" Terms & Conditions",style: TextStyle(
                          color: colorConst.meroon,fontWeight: FontWeight.bold,fontSize: scrWidth*0.035),),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: scrWidth*0.3,
            )


          ],
        ),
      ),

    );;
  }
}
