import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meat_shop_app/constant/color_const.dart';
import 'package:meat_shop_app/constant/image_const.dart';

import 'main.dart';

class orderdetails extends StatefulWidget {
  const orderdetails({super.key});

  @override
  State<orderdetails> createState() => _orderdetailsState();
}

class _orderdetailsState extends State<orderdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding:  EdgeInsets.all(w*0.03),
          child: Container(
              decoration: BoxDecoration(
                  color: colorConst.grey1,
                  borderRadius: BorderRadius.circular(w*0.08)
              ),
              child: Center(child: SvgPicture.asset(iconConst.backarrow))
          ),
        ),
        title: Text("Order details",
          style: TextStyle(
              fontWeight: FontWeight.w600
          ),),
      ),
      body: Padding(
        padding:  EdgeInsets.only(right: w*0.04,left: w*0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "General Info",style: TextStyle(
                    color: colorConst.meroon,fontWeight: FontWeight.bold,fontSize: w*0.035),
                ),
              ],
            ),
            Container(
                height: w*0.33,
                width: w*0.93,
                decoration: BoxDecoration(
                  color: colorConst.white,
                  borderRadius: BorderRadius.circular(w*0.04),
                  border: Border.all(width: w*0.002,color: colorConst.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "   Order ID: #23584",style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: w*0.035),
                        ),
                        Text(
                          "Delivery",style: TextStyle(
                            fontWeight: FontWeight.normal,fontSize: w*0.035),
                        ),
                        Text(
                          "Item: 2",style: TextStyle(
                            fontWeight: FontWeight.normal,fontSize: w*0.035),
                        ),
                      ],),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(children: [
                          Icon(Icons.calendar_month_outlined),
                          Text("15 Mar 2024 - 11 PM  ",style: TextStyle(
                              fontWeight: FontWeight.normal,fontSize: w*0.03))
                        ],),
                        Container(
                          height: w*0.08,
                          width: w*0.4,
                          decoration: BoxDecoration(
                              color: colorConst.meroon,
                              borderRadius: BorderRadius.circular(w*0.04)
                          ),
                          child: Center(
                            child: Text("DigitalPayment",style: TextStyle(
                                color: colorConst.white,fontWeight: FontWeight.normal,fontSize: w*0.03)),
                          ),
                        ),
                        Row(children: [
                          Text("• Delivered",style: TextStyle(
                              color: colorConst.green,fontWeight: FontWeight.normal,fontSize: w*0.03))
                        ],)
                      ],),
                  ],
                )
            ),
            Row(
              children: [
                Text(
                  "Item Info",style: TextStyle(
                    color: colorConst.meroon,fontWeight: FontWeight.bold,fontSize: w*0.035),
                ),
              ],
            ),
            Container(
                height: w*0.34,
                width: w*0.93,
                decoration: BoxDecoration(
                  color: colorConst.white,
                  borderRadius: BorderRadius.circular(w*0.04),
                  border: Border.all(width: w*0.002,color: colorConst.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: w*0.27,
                      width: w*0.27,
                      child: Image(image: AssetImage(imageConst.beefcurrycut),),

                    ),
                    Container(
                      height: w*0.3,
                      width: w*0.49,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Beef Curry Cut ( Lar....",style: TextStyle(
                              color: colorConst.black,fontWeight: FontWeight.bold,fontSize: w*0.035),
                          ),
                          Text(
                            "Chuck,short ribs, skirt,flank",style: TextStyle(
                              color: colorConst.grey,fontWeight: FontWeight.normal,fontSize: w*0.034),
                          ),
                          Row(
                            children: [
                              Text(
                                "Quantiy : ",style: TextStyle(
                                  color: colorConst.black,fontWeight: FontWeight.normal,fontSize: w*0.034),
                              ),
                              Text(
                                "4",style: TextStyle(
                                  color: colorConst.green,fontWeight: FontWeight.normal,fontSize: w*0.034),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "1 KG - ",style: TextStyle(
                                  color: colorConst.black,fontWeight: FontWeight.normal,fontSize: w*0.034),
                              ),
                              Text(
                                "KWD 5.500",style: TextStyle(
                                  color: colorConst.meroon,fontWeight: FontWeight.normal,fontSize: w*0.034),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ),
            Container(
                height: w*0.34,
                width: w*0.93,
                decoration: BoxDecoration(
                  color: colorConst.white,
                  borderRadius: BorderRadius.circular(w*0.04),
                  border: Border.all(width: w*0.002,color: colorConst.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: w*0.27,
                      width: w*0.27,
                      child: Image(image: AssetImage(imageConst.beefcurrycut),),
                    ),
                    Container(
                      height: w*0.3,
                      width: w*0.49,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Beef Curry Cut ( Lar....",style: TextStyle(
                              color: colorConst.black,fontWeight: FontWeight.bold,fontSize: w*0.035),
                          ),
                          Text(
                            "Chuck,short ribs, skirt,flank",style: TextStyle(
                              color: colorConst.grey,fontWeight: FontWeight.normal,fontSize: w*0.034),
                          ),
                          Row(
                            children: [
                              Text(
                                "Quantiy : ",style: TextStyle(
                                  color: colorConst.black,fontWeight: FontWeight.normal,fontSize: w*0.034),
                              ),
                              Text(
                                "4",style: TextStyle(
                                  color: colorConst.green,fontWeight: FontWeight.normal,fontSize: w*0.034),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "1 KG - ",style: TextStyle(
                                  color: colorConst.black,fontWeight: FontWeight.normal,fontSize: w*0.034),
                              ),
                              Text(
                                "KWD 5.500",style: TextStyle(
                                  color: colorConst.meroon,fontWeight: FontWeight.normal,fontSize: w*0.034),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ),
            Row(
              children: [
                Text(
                  "Delivery Details",style: TextStyle(
                    color: colorConst.meroon,fontWeight: FontWeight.bold,fontSize: w*0.035),
                ),
              ],
            ),
            Container(
              width: w*0.9,
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined,color: colorConst.grey,),
                  Column(
                    children: [
                      Text("Annesh babu",style: TextStyle(
                          fontWeight: FontWeight.normal,fontSize: w*0.03)),
                      Text("Sama Tower, Soor Street, Block No.13, Bldg.",style: TextStyle(
                          fontWeight: FontWeight.normal,fontSize: w*0.03)),
                      Text("1, 10th Floor, Office No.2. Kuwait City.",style: TextStyle(
                          fontWeight: FontWeight.normal,fontSize: w*0.03)
                          ,textAlign: TextAlign.left),
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
                    fontWeight: FontWeight.normal,fontSize: w*0.035),
                ),
                Text("KWD 11.000",style: TextStyle(
                    fontWeight: FontWeight.normal,fontSize: w*0.035)
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Discount",style: TextStyle(
                    fontWeight: FontWeight.normal,fontSize: w*0.035),
                ),
                Text("KWD 0.000",style: TextStyle(
                    fontWeight: FontWeight.normal,fontSize: w*0.035)
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Shipping Charge",style: TextStyle(
                    fontWeight: FontWeight.normal,fontSize: w*0.035),
                ),
                Text("KWD 1.000",style: TextStyle(
                    fontWeight: FontWeight.normal,fontSize: w*0.035)
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sub Total",style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: w*0.035),
                ),
                Text("KWD 11.000",style: TextStyle(
                    color: colorConst.meroon,
                    fontWeight: FontWeight.normal,fontSize: w*0.035)
                )
              ],
            ),
          ],),
      ),
    );
  }
}
