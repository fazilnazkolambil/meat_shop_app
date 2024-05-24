import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';

import '../../../main.dart';


class orderdetails extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> data;
  const orderdetails({super.key, required this.data,});

  @override
  State<orderdetails> createState() => _orderdetailsState();
}

class _orderdetailsState extends State<orderdetails> {
  double total = 0;
  double totalPrice = 0;
  double discount = 0;
  double shippingCharge = 50;
  addingTotal(){
    total=0;
    for(int i=0;i<items.length;i++){
      total=items[i]["quantity"]*items[i]["rate"]+total;
      totalPrice=total-discount+shippingCharge;
    }
  }
  List address=[];
  List items=[];
  orderdetailsData()async{
    address=widget.data["address"];
    items=widget.data["items"];
  }

  @override
  void initState() {
     orderdetailsData();
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
        title: Text("Order details",
          style: TextStyle(
              fontWeight: FontWeight.w600
          ),),
      ),
      body: Padding(
        padding:  EdgeInsets.only(right: scrWidth*0.04,left: scrWidth*0.04),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "General Info",style: TextStyle(
                      color: colorConst.meroon,fontWeight: FontWeight.bold,fontSize: scrWidth*0.035),
                  ),
                ],
              ),
              SizedBox(height: scrWidth*0.02,),
              Container(
                  height: scrWidth*0.33,
                  width: scrWidth*0.93,
                  decoration: BoxDecoration(
                    color: colorConst.white,
                    borderRadius: BorderRadius.circular(scrWidth*0.04),
                    border: Border.all(width: scrWidth*0.002,color: colorConst.grey),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.only(right: scrWidth*0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Order ID:${widget.data["orderId"]}",style: TextStyle(
                                fontWeight: FontWeight.w700,fontSize: scrWidth*0.03),
                            ),
                            Text(
                              "Delivery Item:${items.length} ",style: TextStyle(
                                fontWeight: FontWeight.w500,fontSize: scrWidth*0.035),
                            ),
                          ],),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              SvgPicture.asset(iconConst.datetime,color: colorConst.meroon,),
                              SizedBox(width: scrWidth*0.015,),
                              Text("${widget.data["orderDate"]}\n ${widget.data["orderTime"]}",style: TextStyle(
                                  fontWeight: FontWeight.normal,fontSize: scrWidth*0.03))
                            ],),
                            Container(
                              height: scrWidth*0.08,
                              width: scrWidth*0.36,
                              decoration: BoxDecoration(
                                  color: colorConst.meroon,
                                  borderRadius: BorderRadius.circular(scrWidth*0.04)
                              ),
                              child: Center(
                                child: Text(widget.data["paymentStatus"],style: TextStyle(
                                    color: colorConst.white,fontWeight: FontWeight.normal,fontSize: scrWidth*0.03)),
                              ),
                            ),
                            Row(children: [
                              Text("• ${widget.data["orderStatus"]}Delivered",style: TextStyle(
                                  color: colorConst.green,fontWeight: FontWeight.normal,fontSize: scrWidth*0.03))
                            ],)
                          ],),
                      ],
                    ),
                  )
              ),
              SizedBox(height: scrWidth*0.02,),
              Row(
                children: [
                  Text(
                    "Item Info",style: TextStyle(
                      color: colorConst.meroon,fontWeight: FontWeight.bold,fontSize: scrWidth*0.035),
                  ),
                ],
              ),
              SizedBox(height: scrWidth*0.02,),
              ListView.separated(
                itemCount: items.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return  Container(
                        height: scrWidth*0.32,
                        width: scrWidth*0.93,
                        decoration: BoxDecoration(
                          color: colorConst.white,
                          borderRadius: BorderRadius.circular(scrWidth*0.04),
                          border: Border.all(width: scrWidth*0.002,color: colorConst.grey),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: scrWidth*0.27,
                              width: scrWidth*0.27,
                              // child: Image(image: AssetImage(imageConst.beefcurrycut),),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(items[index]["Image"]), fit: BoxFit.fill)
                              ),
                            ),
                            Container(
                              height: scrWidth*0.3,
                              width: scrWidth*0.49,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    items[index]["name"],style: TextStyle(
                                      color: colorConst.black,fontWeight: FontWeight.bold,fontSize: scrWidth*0.035),
                                  ),
                                  Text(
                                    items[index]["ingredients"],style: TextStyle(
                                      fontSize: scrWidth*0.034),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Quantity : ",style: TextStyle(
                                          color: colorConst.black,fontWeight: FontWeight.normal,fontSize: scrWidth*0.034),
                                      ),
                                      Text(
                                        items[index]["quantity"].toString(),style: TextStyle(
                                          color: colorConst.green,fontWeight: FontWeight.normal,fontSize: scrWidth*0.034),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "1 KG - ",style: TextStyle(
                                          color: colorConst.black,fontWeight: FontWeight.normal,fontSize: scrWidth*0.034),
                                      ),
                                      Text(
                                        "₹ ${items[index]["rate"]}.00",style: TextStyle(
                                          color: colorConst.meroon,fontWeight: FontWeight.bold,fontSize: scrWidth*0.034),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                    );
                  },
                separatorBuilder:(context, index) {
                  return SizedBox(height: scrWidth*0.04,);
                },
              ),
              SizedBox(height: scrWidth*0.02,),
              Row(
                children: [
                  Text(
                    "Delivery Details",style: TextStyle(
                      color: colorConst.meroon,fontWeight: FontWeight.bold,fontSize: scrWidth*0.035),
                  ),
                ],
              ),
              SizedBox(height: scrWidth*0.02,),
              Container(
                width: scrWidth*0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on_outlined,color: colorConst.grey,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(address[0]["name"],style: TextStyle(
                            color: colorConst.black,fontWeight: FontWeight.w500,fontSize: scrWidth*0.03)),
                        Text(address[0]["address"],style: TextStyle(
                            color: colorConst.black,fontWeight: FontWeight.w500,fontSize: scrWidth*0.03)),
                        Text("${address[0]["houseno"]}, ${address[0]["landmark"]} ",style: TextStyle(
                            color: colorConst.black,fontWeight: FontWeight.w500,fontSize: scrWidth*0.03)
                            ,textAlign: TextAlign.left),
                        Text(address[0]["number"],style: TextStyle(
                            color: colorConst.black,fontWeight: FontWeight.w500,fontSize: scrWidth*0.03)),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Item Price",style: TextStyle(
                      fontWeight: FontWeight.normal,fontSize: scrWidth*0.035),
                  ),
                  Text("₹ ${total}",style: TextStyle(
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
                  Text("₹ ${discount}",style: TextStyle(
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
                  Text("₹ ${shippingCharge}",style: TextStyle(
                      fontWeight: FontWeight.normal,fontSize: scrWidth*0.035)
                  )
                ],
              ),
              SizedBox(height: scrWidth*0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sub Total",style: TextStyle(
                      fontWeight: FontWeight.w700,fontSize: scrWidth*0.035),
                  ),
                  Text("₹ ${totalPrice}",style: TextStyle(
                      color: colorConst.meroon,
                      fontWeight: FontWeight.w700,fontSize: scrWidth*0.035)
                  )
                ],
              ),
              SizedBox(height: scrWidth*0.01,),
            ],),
        ),
      ),
    );
  }
}
