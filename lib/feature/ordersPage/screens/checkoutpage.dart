import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/ordersPage/screens/orderdetails_page.dart';
import 'package:meat_shop_app/models/addressModel.dart';
import 'package:meat_shop_app/models/orderDetailsModel.dart';
import 'package:meat_shop_app/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../homePage/screens/meatList.dart';
import '../../onboardPage/screens/NavigationPage.dart';
import 'cart_page.dart';
import 'orderconfirm_page.dart';

class checkoutpage extends StatefulWidget {
  final String price;
  final String discount;
  final String shippingCharge;
  final String subtotal;
  final List cartMeat;
  final OrderDetailsModel orderdetailsdata;
  const checkoutpage({super.key, required this.price,required this.discount,required this.shippingCharge,required this.subtotal, required this.orderdetailsdata, required this.cartMeat});

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
    await FirebaseFirestore.instance.collection("users").doc("$loginId").get().then((value) {
      userModel = UserModel.fromMap(value.data()!);
    });
    UserModel tempuserModel=userModel!.copyWith(
      address: addre
    );
    await FirebaseFirestore.instance.collection("users").doc("$loginId").update(tempuserModel.toMap());
  }
  List orderHistory=[];
  List address=  [];
  autoFill() async {
    var data= await FirebaseFirestore.instance.collection("users").doc("$loginId").get();
    Map a = data.data()!;
    address = a["address"];
    print(address);
    numberController.text=address[0]["number"];
    pincodeController.text=address[0]["pincode"];
    addressController.text=address[0]["address"];
    nameController.text=address[0]["name"];
    landmarkController.text=address[0]["landmark"];
    housenoController.text=address[0]["houseno"];
  }
  String? _d1;
   String? _t1;
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
  orderhisAdd(){
    orderHistory.add({
      "order Date":"",
      "total Price":widget.subtotal,
      "items Ordered":widget.cartMeat,
      "orderStatus":"",
    });
    setState(() {

    });
    print(orderHistory);
  }
   @override
  void initState() {
     autoFill();
     loadData();
     orderhisAdd();
    // TODO: implement initState
    super.initState();
  }
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
              SizedBox(
                width: scrWidth*0.9,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Amount",style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: scrWidth*0.035),
                        ),
                        Text("₹ ${widget.subtotal}.00",style: TextStyle(
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
                  if(check == true && pymnt != ""){
                    OrderDetailsModel orderdetailsModel=widget.orderdetailsdata.copyWith(
                      paymentStatus: pymnt,
                      address: addre,
                      orderHistory: orderHistory,
                      items: widget.cartMeat
                    );

                    FirebaseFirestore.instance.collection("orderDetails").add(orderdetailsModel.toMap());
                    Navigator.push(context, MaterialPageRoute(builder: (context) => orderconfirm(),));
                  }else{
                    pymnt == ""?
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select a payment method!")))
                        :ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please agree to our terms  and conditions!")));
                  }
                },
                child: Container(
                  height: scrWidth*0.13,
                  width: scrWidth*0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(scrWidth*0.04),
                      color: check == true && pymnt != ""?colorConst.meroon:colorConst.grey
                  ),
                  child: Center(child: Text("Confirm Order",style: TextStyle(color: colorConst.white,fontWeight: FontWeight.bold,fontSize: scrWidth*0.035),)),
                ),
              )
            ]

        ),
      ),
      appBar: AppBar(
        leading: Padding(
          padding:EdgeInsets.all(scrWidth*0.03),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
                backgroundColor: colorConst.grey1,
                child: Center(child: SvgPicture.asset(iconConst.backarrow))),
          ),
        ),
        title: Text("Checkout",
          style: TextStyle(
              fontWeight: FontWeight.w600
          ),),
        actions: [
          // InkWell(
          //     onTap: () {
          //       //print(meatDetailCollection);
          //       Navigator.push(context, MaterialPageRoute(builder: (context) => cartPage(),));
          //     },
          //     child: addCart.isEmpty?
          //     SvgPicture.asset(iconConst.cart):
          //     SizedBox(
          //       height: scrWidth*0.08,
          //       width: scrWidth*0.08,
          //       child: Stack(
          //         children: [
          //           Positioned(
          //             bottom: scrWidth*0.03,
          //             left: scrWidth*0.03,
          //             child: CircleAvatar(
          //               backgroundColor: colorConst.meroon,
          //               radius: scrWidth*0.025,
          //               child: Center(
          //                 child: Text(addCart.length.toString(),style: TextStyle(
          //                     color: colorConst.white,
          //                     fontWeight: FontWeight.w600,
          //                     fontSize: scrWidth*0.03
          //                 ),),
          //               ),
          //             ),
          //           ),
          //           Positioned(
          //               left: 0,
          //               bottom: 0,
          //               child: SvgPicture.asset(iconConst.cart,)),
          //         ],
          //       ),
          //     )),
          //SizedBox(width: scrWidth*0.04,),
          SvgPicture.asset(iconConst.notification),
          SizedBox(width: scrWidth*0.05,),
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
                        isScrollControlled: true,
                        // showDragHandle: true,
                        backgroundColor: colorConst.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(scrWidth*0.07,),
                            topRight: Radius.circular(scrWidth*0.07),
                          ),
                        ),
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                              height: scrWidth*1.8,
                              width: scrWidth*1,
                              padding: EdgeInsets.all(scrWidth*0.03),
                              child: ListView(
                               shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Add New Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: scrWidth*0.035)
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                          child: SizedBox(
                                            height: scrWidth*0.04,
                                            width: scrWidth*0.04,
                                              child: SvgPicture.asset(iconConst.cross))
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: scrWidth*1.75,
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
                                ],
                              ),
                                                          ),
                            ],
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
                                  // DateTimePicker(
                                  //   initialSelectedDate: DateTime.now(),
                                  //   startDate: DateTime.now(),
                                  //   // endDate: date!.add(Duration(days: 60)),
                                  //   startTime: DateTime.now(),
                                  //   // endTime: DateTime(date!.year, date!.month, date!.day, 18),
                                  //   timeInterval: Duration(minutes: 15),
                                  //   // datePickerTitle: 'Pick your preferred date',
                                  //   // timePickerTitle: 'Pick your preferred time',
                                  //   // timeOutOfRangeError: 'Sorry shop is closed now',
                                  //   // is24h: false,
                                  //   onDateChanged: (date) {
                                  //     setState(() {
                                  //       _d1 = DateFormat('dd MMM, yyyy').format(date);
                                  //     });
                                  //   },
                                  //   onTimeChanged: (time) {
                                  //     setState(() {
                                  //       _t1 = DateFormat('hh:mm:ss aa').format(time);
                                  //     });
                                  //   },
                                  // )
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
            SizedBox(
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
                      Text("₹ ${widget.price}.00",style: TextStyle(
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
                      Text("₹ ${widget.discount}.00",style: TextStyle(
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
                      Text("₹ ${widget.shippingCharge}.00",style: TextStyle(
                          fontWeight: FontWeight.normal,fontSize: scrWidth*0.035)
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: scrWidth*0.2,
              width: scrWidth,
              //color: colorConst.grey,
              child: Row(
                children: [
                  Checkbox(
                    activeColor: colorConst.meroon,
                    value: check,
                      onChanged: (value) {
                    setState(() {
                      check=value!;
                    });
                      },),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text("I have read and agreed with ",style: TextStyle(
                              color: colorConst.black,fontSize: scrWidth*0.032
                          ),),
                          Text(" Privacy Policy ",style: TextStyle(
                              color: colorConst.meroon,fontWeight: FontWeight.bold,fontSize: scrWidth*0.032
                          ),),
                        ],
                      ),
                      Row(
                        children: [
                          Text(" and ",style: TextStyle(
                              color: colorConst.black,fontSize: scrWidth*0.032
                          ),),
                          Text(" Terms & Conditions",style: TextStyle(
                              color: colorConst.meroon,fontWeight: FontWeight.bold,fontSize: scrWidth*0.032),),
                        ],
                      )

                    ],
                  )

                ],
              ),
            ),

            SizedBox(
              height: scrWidth*0.34,
            )
          ],
        ),
      ),

    );
  }
}
