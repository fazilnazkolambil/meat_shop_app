import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
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
  List items = [];
  Map address = {};
  String selectedDate = '';
  String selectedTime = '';

  convertData(){
    items=widget.data["items"];
    address=widget.data["deliveryAddress"];
     selectedDate = DateFormat.MMMEd().format(DateTime.parse(widget.data['selectedTime']));
     selectedTime = DateFormat.jm().format(DateTime.parse(widget.data['selectedTime']));
  }
  @override
  void initState() {
    convertData();
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConst.white,
      appBar: AppBar(
        backgroundColor: colorConst.white,
        surfaceTintColor: colorConst.white,
        leading: Padding(
          padding:  EdgeInsets.all(scrWidth*0.02),
          child: GestureDetector(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "General Info",style: TextStyle(
                  color: colorConst.meroon,fontWeight: FontWeight.bold,fontSize: scrWidth*0.035),
              ),
              SizedBox(height: scrWidth*0.02,),
              Container(
                  height: scrWidth*0.33,
                  width: scrWidth*0.97,
                  decoration: BoxDecoration(
                    // color: colorConst.white,
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
                                "Order ID : ${widget.data["orderId"].toString().substring(0,10)}",style: TextStyle(
                                fontWeight: FontWeight.w700,fontSize: 12),
                            ),
                            Text(
                              "Delivery Item : ${items.length} ",style: TextStyle(
                                fontWeight: FontWeight.w700,fontSize: 12),
                            ),
                          ],),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(iconConst.datetime,color: colorConst.meroon,),
                              SizedBox(width: scrWidth*0.015,),
                              Text("$selectedDate - $selectedTime",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,fontSize: 13))
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Icon(Icons.circle,
                                  color: widget.data["orderStatus"] == "Delivered"?colorConst.green
                                      :Colors.orange,
                                    ),
                                Text(
                                  "  ${widget.data["orderStatus"]}", style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: scrWidth * 0.033,
                                    color: widget.data["orderStatus"] == "Delivered"?colorConst.green:colorConst.orange
                                ),),
                              ],
                            ),
                          ],),
                      ],
                    ),
                  )
              ),
              SizedBox(height: scrWidth*0.02,),
              Text(
                "Item Info",style: TextStyle(
                  color: colorConst.meroon,fontWeight: FontWeight.bold,fontSize: scrWidth*0.035),
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
                                    image: NetworkImage(items[index]["image"]), fit: BoxFit.fill)
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
                                        '${items[index]["qty"]} KG',style: TextStyle(
                                          color: colorConst.meroon,fontWeight: FontWeight.bold,fontSize: scrWidth*0.034),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Price : ",style: TextStyle(
                                          color: colorConst.black,fontWeight: FontWeight.normal,fontSize: scrWidth*0.034),
                                      ),
                                      Text(
                                        "₹ ${items[index]["rate"] * items[index]["qty"]}/-",style: TextStyle(
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
                  return SizedBox(height: 10,);
                },
              ),
              SizedBox(height: scrWidth*0.02,),
              Text(
                "Delivery Details",style: TextStyle(
                  color: colorConst.meroon,fontWeight: FontWeight.bold,fontSize: scrWidth*0.035),
              ),
              SizedBox(height: scrWidth*0.02,),
              Container(
                width: scrWidth*0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.location_on_outlined,color: colorConst.grey,),
                    SizedBox(
                      width: scrWidth*0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('To ${address['type']}',style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: colorConst.meroon
                          )),
                          Text('${address['name']},\n'
                              '${address['buildingName']},'
                              ' ${address['street']},'
                              ' ${address['town']},'
                              ' ${address['pincode']}.',textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Item Price",style: TextStyle(
                      fontWeight: FontWeight.normal,fontSize: 12),
                  ),
                  Text("₹ ${widget.data['itemPrice']}",style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 12,color: colorConst.meroon)
                  )
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Discount",style: TextStyle(
                      fontWeight: FontWeight.normal,fontSize: 12),
                  ),
                  Text("₹ ${widget.data['discount']}",style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 12,color: colorConst.meroon)
                  )
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shipping Charge",style: TextStyle(
                      fontWeight: FontWeight.normal,fontSize: 12),
                  ),
                  Text("₹ ${widget.data['shippingCharge']}",style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 12,color: colorConst.meroon)
                  )
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sub Total",style: TextStyle(
                      fontWeight: FontWeight.w700,fontSize: 15),
                  ),
                  Text("₹ ${widget.data['totalPrice']}/-",style: TextStyle(
                      color: colorConst.meroon,
                      fontWeight: FontWeight.w700,fontSize: 15)
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
