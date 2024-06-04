import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/morePage/screens/addnewaddress.dart';
import 'package:meat_shop_app/feature/morePage/screens/myaddress.dart';
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

class CheckoutPage extends StatefulWidget {
  final  double price;
  final double discount;
  final double shippingCharge;
  final double subtotal;
  final List cartMeat;
  final String notes;
  // final  List<QueryDocumentSnapshot<Map<String, dynamic>>> data;
  // final OrderDetailsModel orderdetailsdata;
  const CheckoutPage({super.key, required this.price,required this.discount,required this.shippingCharge,required this.subtotal, required this.cartMeat, required this.notes,});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

  addOrderDetails()async{
    OrderDetailsModel OrderDetailsData=
    OrderDetailsModel(
      userId:loginId.toString(),
      paymentStatus: selectedPayment,
      orderStatus: "Ordered",
      orderDate:selectedDate.isEmpty?"${DateFormat.yMMMMEEEEd().format(DateTime.now()).toString()}"
          :"${DateFormat.yMMMMEEEEd().format(selectedDate.last!).toString()}",
      totalPrice:widget.subtotal,
      items: widget.cartMeat,
      deliveryAddress: selectedAddress,
      orderId: '',
      orderTime: selectedTime.toString(),
      notes: widget.notes
    );
    await FirebaseFirestore.instance.collection("orderDetails").add(OrderDetailsData.toMap())
        .then((value) => value.update({
        "orderId":value.id
    }));
  }



  String? chooseAddress;
  List <Map<String,dynamic>> allAddress = [];
  String? userName;
  String? userNumber;
  List addressData = [];
  Future getUser () async {
    var data = await FirebaseFirestore.instance.collection('users').doc(loginId).get();
    userName = data['name'];
    userNumber = data['number'];
    addressData = [];
    for (int i = 0; i < data['address'].length; i++){
      addressData.add(data["address"][i]["type"]);
      if(chooseAddress.toString() == data['address'][i]['type']){
        selectedAddress = addressModel(
            name: data["address"][i]["name"],
            number: data["address"][i]["number"],
            location: data["address"][i]["location"],
            pincode: data["address"][i]["pincode"],
            deliveryInstruction: data["address"][i]["deliveryInstruction"],
            buildingName: data["address"][i]["buildingName"],
            street: data["address"][i]["street"],
            town: data["address"][i]["town"],
            type: data["address"][i]["type"]
        ).toMap();
      }
      setState(() {

      });
      // allAddress.add(data.data()!);
    }
  }

  List selectedDate = [];
  String selectedTime = '';
  Map selectedAddress = {};
  int selectedIndex = -1;
  List time=[
    "9:00 AM",
    "12:00 PM",
    "3:00 PM",
    "6:00 PM",
  ];

  var selectedPayment;
  List paymentMethods = [
    'Cash On Delivery', 'Credit Card', 'Debit Card'
  ];

  bool check = false;
  bool loading = false;
   @override
  void initState() {
     getUser();
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
                            color: colorConst.black,
                            fontSize: scrWidth*0.05,
                            fontWeight: FontWeight.w600
                        ),
                        ),
                        Text("₹ ${widget.subtotal}",style: TextStyle(
                            color: colorConst.meroon,
                            fontSize: scrWidth*0.05,
                            fontWeight: FontWeight.w600
                        )
                        )
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  if(
                  chooseAddress != null &&
                      selectedTime.isNotEmpty &&
                      selectedPayment != null &&
                      check == true
                  ){
                    addOrderDetails();
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.remove("cart");
                    prefs.remove("cart2");
                    addCart.clear();
                   Future.delayed(const Duration(seconds: 1)).then((value) {
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const orderconfirm(),));
                   });
                  }else{
                    chooseAddress == null?
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select an Address!"))):
                        selectedTime.isEmpty?
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select a delivery Time!"))):
                        selectedPayment == null ?
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select a Payment method!"))):
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please read and agree to our Privacy Policy and Terms and Conditions!")));
                  }
                },
                child: Container(
                  height: scrWidth*0.13,
                  width: scrWidth*0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(scrWidth*0.04),
                      color: check?colorConst.meroon:colorConst.grey
                  ),
                  child: loading?Lottie.asset(gifs.loadingGif):
                  Center(child: Text("Confirm Order",style: TextStyle(color: colorConst.white,fontWeight: FontWeight.bold,fontSize: scrWidth*0.035),)),
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
        title: InkWell(
          onTap: () {
           // print(userAddress);
          },
          child: Text("Checkout",
            style: TextStyle(
                fontWeight: FontWeight.w600
            ),),
        ),
        actions: [
          SvgPicture.asset(iconConst.notification),
          SizedBox(width: scrWidth*0.05,),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await getUser();
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: scrHeight*0.01,),
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
                    SizedBox(
                      width: scrWidth*0.5,
                      height: scrWidth*0.1,
                      child:
                      addressData.isEmpty?Center(
                        child: Text("No Saved Address",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,fontSize: scrWidth*0.035
                          ),),
                      ):
                      DropdownButton(
                        isExpanded: true,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        underline: SizedBox(),
                        hint: Text(
                          "Select Saved Address",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,fontSize: scrWidth*0.035
                          ),
                        ),
                        style: TextStyle(
                            color: colorConst.black),
                        value: chooseAddress,
                        items: addressData.map((valueItem){
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                        onChanged: (value) {
                          chooseAddress = value.toString();
                          getUser();
                          // print("dhasudhasd");
                          // allAddress.where((element) => element[""]);
                          setState(() {});
                        },
                      ),
                    ),
                    //Text("Select Saved Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: scrWidth*0.035),),
                    InkWell(
                      onTap: () {
                        getUser();
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>addnewaddress(
                            userName: userName.toString(),
                            userNumber: userNumber.toString(),
                            types: addressData,
                        ),
                        ));
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
              SizedBox(height: scrHeight*0.01,),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (BuildContext context, void Function(void Function()) setState) {
                          return AlertDialog(
                            backgroundColor: colorConst.white,
                            surfaceTintColor: colorConst.grey,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(scrWidth*0.05)),
                            title: Column(
                              children: [
                                Row(
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
                                      child: SizedBox(
                                          height: scrWidth*0.04,
                                          child: SvgPicture.asset(iconConst.cross)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            content: SizedBox(
                              height: scrWidth*1,
                              width: scrWidth*1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(selectedDate.isEmpty?DateFormat.yMMM().format(DateTime.now()).toString():"${DateFormat.yMMM().format(selectedDate.last!).toString()}",style: TextStyle(
                                      color: colorConst.meroon,
                                      fontWeight: FontWeight.bold,
                                      fontSize: scrWidth*0.04
                                  ),),
                                  SizedBox(
                                    height: scrWidth*0.25,
                                    width: scrWidth*1,
                                    child: DatePicker(
                                      DateTime.now(),
                                      initialSelectedDate: selectedDate.isEmpty?DateTime.now():selectedDate.last,
                                      daysCount: 7,
                                      selectionColor: colorConst.meroon,
                                      selectedTextColor: Colors.white,
                                      onDateChange: (date) {
                                        selectedDate.add(date);
                                        setState(() {
                                          // _selectedValue = date;
                                        });
                                      },
                                    ),
                                  ),
                                  Text(
                                      selectedDate.isEmpty?DateFormat.yMMMMEEEEd().format(DateTime.now()).toString()
                                          :"${DateFormat.yMMMMEEEEd().format(selectedDate.last!).toString()}",
                                      style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: scrWidth*0.035)),
                                  Text("Select a Time",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: scrWidth*0.04,
                                      color: colorConst.meroon
                                      )),
                                  SizedBox(
                                      height: scrWidth*0.28,
                                      width: scrWidth*1,
                                      // color: colorConst.grey,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: GridView.builder(
                                              shrinkWrap: true,
                                              itemCount: time.length,
                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  mainAxisSpacing: scrWidth*0.03,
                                                  crossAxisSpacing: scrWidth*0.03,
                                                  //childAspectRatio: 10,
                                                  mainAxisExtent: 40
                                              ),
                                              itemBuilder: (BuildContext context, int index) {
                                                return InkWell(
                                                  onTap: () {
                                                    selectedIndex = index;
                                                    selectedTime = time[index];
                                                    print(selectedTime);
                                                    setState((){

                                                    });
                                                  },
                                                  child: Container(
                                                    //height: scrWidth*0.03,
                                                    width: scrWidth*0.31,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(scrWidth*0.04),
                                                        // color: colorConst.green,
                                                        border:selectedIndex == index? Border.all(width: scrWidth*0.005,color: colorConst.meroon):Border.all(width: scrWidth*0.005,color: colorConst.grey)
                                                    ),
                                                    child: Center(child: Text(time[index])),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // addOrderHistory();
                                      if(selectedTime.isNotEmpty){
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Container(
                                      height: scrWidth*0.11,
                                      width: scrWidth*0.6,
                                      decoration: BoxDecoration(
                                          color: selectedTime.isEmpty?colorConst.grey:colorConst.meroon,
                                          borderRadius: BorderRadius.circular(scrWidth*0.04)
                                      ),
                                      child: Center(child: Text("OK",style: TextStyle(color: Colors.white),)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },);
                },
                child: Container(
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
                      CircleAvatar(
                        child: SvgPicture.asset(iconConst.datetime),
                        backgroundColor: colorConst.meroon,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: scrHeight*0.01,),
              Container(
                //height: scrWidth*0.5,
                width: scrWidth*0.9,
                padding: EdgeInsets.all(scrWidth*0.03),
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
                        SizedBox(
                          height: scrWidth*0.4,
                          child: ListView.separated(
                            itemCount: paymentMethods.length,
                            itemBuilder: (BuildContext context, int index) {
                              return RadioMenuButton(
                                style: ButtonStyle(
                                  surfaceTintColor: MaterialStatePropertyAll(colorConst.meroon)
                                ),
                                  value: paymentMethods[index],
                                  groupValue: selectedPayment,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPayment = value;
                                    });
                                  },
                                  child: Text(paymentMethods[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: scrWidth*0.035
                                  ),
                                  )
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => SizedBox(),


                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: scrHeight*0.01,),
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
                        Text("₹ ${widget.price}",style: TextStyle(
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
                        Text("₹ ${widget.discount}",style: TextStyle(
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
                        Text("₹ ${widget.shippingCharge}",style: TextStyle(
                            fontWeight: FontWeight.normal,fontSize: scrWidth*0.035)
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: scrHeight*0.02,),
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
              SizedBox(height: scrHeight*0.2,),
            ],
          ),
        ),
      ),

    );
  }
}
