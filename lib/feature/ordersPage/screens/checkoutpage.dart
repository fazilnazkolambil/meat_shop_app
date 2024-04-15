import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/models/addressModel.dart';
import 'package:meat_shop_app/models/userModel.dart';

import '../../../main.dart';
import 'orderconfirm_page.dart';

class checkoutpage extends StatefulWidget {
  const checkoutpage({super.key});

  @override
  State<checkoutpage> createState() => _checkoutpageState();
}

class _checkoutpageState extends State<checkoutpage> {
  var countryCode;
  TextEditingController addressController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController numberController=TextEditingController();
  TextEditingController landmarkController=TextEditingController();
  TextEditingController housenoController=TextEditingController();
  TextEditingController pincodeController=TextEditingController();
  String pymnt="";
  String labelas="";
  bool check=false;
  List <DateTime?> date=[];
  List addre=[];
  int date1=0;
  UserModel? userModel;
  addAddress()async{
    addre.add(addressModel(
      name: nameController.text,
      number:numberController.text,
      landmark: landmarkController.text,
      houseno: housenoController.text,
      pincode: pincodeController.text,
      address: addressController.text,

    ).toMap());
    await FirebaseFirestore.instance.collection("users").doc("+918555535689").get().then((value) {
      userModel = UserModel.fromMap(value.data()!);
    });
    UserModel tempuserModel=userModel!.copyWith(
      address: addre
    );
    await FirebaseFirestore.instance.collection("users").doc("+918555535689").update(tempuserModel.toMap());
  }
  String? _d1;
   String? _t1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
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
                        enableDrag: false,
                        elevation: 20,
                        scrollControlDisabledMaxHeightRatio: Checkbox.width,
                        isScrollControlled: false,
                        // showDragHandle: true,
                        backgroundColor: colorConst.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(scrWidth*0.07,),
                            topRight: Radius.circular(scrWidth*0.07),
                          ),
                        ),
                        builder: (context) {
                          return Container(
                            height: scrWidth*1.89,
                            width: scrWidth*1,
                            child: Padding(
                              padding:  EdgeInsets.all(scrWidth*0.03),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          child: Container(
                                            height: scrWidth*0.04,
                                            width: scrWidth*0.04,
                                              child: SvgPicture.asset(iconConst.cross))
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: scrWidth*1.7,
                                    child: SingleChildScrollView(
                                      child: Container(
                                        // height: scrWidth*2.3,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Stack(
                                              children:[
                                                Container(
                                                height: scrWidth*0.8,
                                                width: scrWidth*1,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(scrWidth*0.03),color: colorConst.grey),
                                                child: Image(image: AssetImage(imageConst.map1),fit: BoxFit.fill,),
                                              ),
                                                Positioned(
                                                  left: scrWidth*0.4,
                                                  top: scrWidth*0.35,
                                                    child: SvgPicture.asset(iconConst.location1)
                                                ),
                                                Positioned(
                                                    right: scrWidth*0.05,
                                                    top: scrWidth*0.07,
                                                    child: SvgPicture.asset(iconConst.gpsicon)
                                                ),
                                                Positioned(
                                                  left: scrWidth*0.05,
                                                  top: scrWidth*0.06,
                                                  child: Container(
                                                    height: scrWidth*0.11,
                                                    width: scrWidth*0.65,
                                                    decoration: BoxDecoration(
                                                      color: colorConst.white,
                                                      borderRadius: BorderRadius.circular(scrWidth*0.06),
                                                    ),
                                                    child: TextField(
                                                      decoration: InputDecoration(
                                                          border: InputBorder.none,
                                                          labelText: "  Search",
                                                          labelStyle:  TextStyle(color: colorConst.grey,fontWeight: FontWeight.normal,fontSize: scrWidth*0.035)
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                              ]
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
                                                controller: addressController,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    labelText: " Address",
                                                    labelStyle:  TextStyle(color: colorConst.grey,fontWeight: FontWeight.normal,fontSize: scrWidth*0.035)
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
                                                    controller: nameController,
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        labelText: " Name",
                                                        labelStyle:  TextStyle(color: colorConst.grey,fontWeight: FontWeight.normal,fontSize: scrWidth*0.035)

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
                                                    controller: numberController,
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        labelText: " Mob no",
                                                        labelStyle:  TextStyle(color: colorConst.grey,fontWeight: FontWeight.normal,fontSize: scrWidth*0.035)
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
                                                controller: landmarkController,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    labelText: " Land mark",
                                                    labelStyle:  TextStyle(color: colorConst.grey,fontWeight: FontWeight.normal,fontSize: scrWidth*0.035)

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
                                                    controller: housenoController,
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        labelText: " House no",
                                                        labelStyle:  TextStyle(color: colorConst.grey,fontWeight: FontWeight.normal,fontSize: scrWidth*0.035)
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
                                                    controller: pincodeController,
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        labelText: " Pincode",
                                                        labelStyle:  TextStyle(color: colorConst.grey,fontWeight: FontWeight.normal,fontSize: scrWidth*0.035)
                                                    ),
                                                  ),
                                                ),
                                              ],),
                                            InkWell(
                                              onTap: () {
                                                addAddress();

                                                   print("lllllllll$addre");
                                                setState(() {

                                                });
                                                // Navigator.pop(context);
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
                                    ),
                                  ),
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
                                Text(
                                  "Select Delivery Date & Time",style: TextStyle(fontWeight: FontWeight.bold,fontSize: scrWidth*0.035),
                                ),
                                // SizedBox(width: scrWidth*0.3,),
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: SvgPicture.asset(iconConst.cross),
                                )
                              ],
                            ),

                            content: Container(
                              height: scrWidth*1,
                              width: scrWidth*0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(scrWidth*0.06),

                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  DateTimePicker(
                                    initialSelectedDate: DateTime.now(),
                                    startDate: DateTime.now(),
                                    // endDate: date!.add(Duration(days: 60)),
                                    startTime: DateTime.now(),
                                    // endTime: DateTime(date!.year, date!.month, date!.day, 18),
                                    timeInterval: Duration(minutes: 15),
                                    // datePickerTitle: 'Pick your preferred date',
                                    // timePickerTitle: 'Pick your preferred time',
                                    // timeOutOfRangeError: 'Sorry shop is closed now',
                                    // is24h: false,
                                    onDateChanged: (date) {
                                      setState(() {
                                        _d1 = DateFormat('dd MMM, yyyy').format(date);
                                      });
                                    },
                                    onTimeChanged: (time) {
                                      setState(() {
                                        _t1 = DateFormat('hh:mm:ss aa').format(time);
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        },);
                    },
                    child: CircleAvatar(
                      child: SvgPicture.asset(iconConst.datetime),
                      backgroundColor: colorConst.meroon,
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
              height: scrWidth*0.2,
              width: scrWidth*0.92,
              // color: colorConst.grey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Checkbox(
                        value: check,
                          onChanged: (value) {
                        setState(() {
                          check=value!;
                        });
                          },),
                      Text("I have read and agreed with ",style: TextStyle(
                          color: colorConst.black,fontWeight: FontWeight.normal,fontSize: scrWidth*0.032
                      ),),
                      Text(" Privacy Policy ",style: TextStyle(
                          color: colorConst.meroon,fontWeight: FontWeight.bold,fontSize: scrWidth*0.032
                      ),),
                    ],
                  ),
                  Row(
                    children: [
                      Text(" and ",style: TextStyle(
                          color: colorConst.black,fontWeight: FontWeight.normal,fontSize: scrWidth*0.032
                      ),),
                      Text(" Terms & Conditions",style: TextStyle(
                          color: colorConst.meroon,fontWeight: FontWeight.bold,fontSize: scrWidth*0.032),),
                    ],
                  ),
                  // SizedBox(height: scrWidth*0.02,)
                ],
              ),
            ),

            SizedBox(
              height: scrWidth*0.34,
            )


          ],
        ),
      ),

    );;
  }
}
