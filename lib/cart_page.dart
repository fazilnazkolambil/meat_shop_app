import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meat_shop_app/checkoutpage.dart';
import 'package:meat_shop_app/constant/color_const.dart';
import 'package:meat_shop_app/constant/image_const.dart';

import 'main.dart';

class cartPage extends StatefulWidget {
  const cartPage({super.key});

  @override
  State<cartPage> createState() => _CartPageState();
}

class _CartPageState extends State<cartPage> {
  int count=1;
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
        title: Text("My Cart",
        style: TextStyle(
          fontWeight: FontWeight.w800
        ),),
        actions: [
          Container(child: SvgPicture.asset(iconConst.cart)),
          SizedBox(width: w*0.04,),
          Container(child: SvgPicture.asset(iconConst.notification)),
          SizedBox(width: w*0.03,),
        ],
      ),
      bottomNavigationBar:Container(
        height: w*0.37,
        decoration: BoxDecoration(
          color: colorConst.white,
          borderRadius: BorderRadius.circular(w*0.07),
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
          padding:  EdgeInsets.all(w*0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Subtotal",
                    style: TextStyle(
                        color: colorConst.black,
                        fontSize: w*0.05,
                        fontWeight: FontWeight.w700
                    ),),
                  Text("₹ 300.00",
                    style: TextStyle(
                        color: colorConst.meroon,
                        fontSize: w*0.05,
                        fontWeight: FontWeight.w700
                    ),)
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => checkoutpage(),));
                },
                child: Container(
                  height: w*0.15,
                  width: w*0.9,
                  decoration: BoxDecoration(
                    color: colorConst.meroon,
                    borderRadius: BorderRadius.circular(w*0.05),
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
      ) ,
      body: Padding(
        padding:  EdgeInsets.all(w*0.028),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Container(
                        height: w*0.33,
                        decoration: BoxDecoration(
                            color: colorConst.white,
                          borderRadius: BorderRadius.circular(w*0.04),
                          border: Border.all(
                              width: w*0.0003,
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
                            SizedBox(width: w*0.02,),
                            Container(
                              height: w*0.27,
                              width: w*0.27,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(w*0.04),
                                border: Border.all(
                                    width: w*0.0003,
                                    color: colorConst.black.withOpacity(0.38)
                                ),
                                image: DecorationImage(image: AssetImage(imageConst.beefcurrycut),fit: BoxFit.fill))
                              ),
                            SizedBox(width: w*0.02,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: w*0.4,
                                  child: Column(
                                    children: [
                                      Text("Beef Curry Cut(Large.)",
                                        style: TextStyle(
                                            fontSize: w*0.04,
                                            fontWeight: FontWeight.w700,
                                            color: colorConst.black
                                        ),),
                                      Text("Chuck, short ribs, skirt, flank"),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("1 KG - ",
                                      style: TextStyle(
                                          fontSize: w*0.04,
                                          fontWeight: FontWeight.w700,
                                          color: colorConst.black
                                      ),),
                                    Text("₹ 250",
                                      style: TextStyle(
                                          fontSize: w*0.04,
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
                                Container(
                                  height: w*0.1,
                                  width: w*0.1,
                                     decoration: BoxDecoration(
                                       color: colorConst.white,
                                       borderRadius: BorderRadius.circular(w*0.05),
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
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        count++;
                                        setState(() {

                                        });
                                      },
                                      child: Container(
                                        height:w*0.065,
                                        width:w*0.065,
                                        decoration: BoxDecoration(
                                            color:colorConst.grey1,
                                            borderRadius: BorderRadius.circular(w*0.06),
                                            border: Border.all(
                                                width: w*0.0003,
                                                color: colorConst.black.withOpacity(0.38)
                                            )
                                        ),
                                        child:Icon(Icons.remove,
                                            size:w*0.04),
                                      ),
                                    ),
                                    SizedBox(width: w*0.015,),
                                    Text(count.toString(),
                                      style: TextStyle(
                                        fontSize: w*0.04,
                                        fontWeight: FontWeight.w600
                                      ),),
                                    SizedBox(width: w*0.015,),
                                    InkWell(
                                      onTap: () {
                                        count<=0? 0:count--;
                                        setState(() {

                                        });
                                      },
                                      child: Container(
                                          height:w*0.065,
                                          width:w*0.065,
                                          decoration: BoxDecoration(
                                            color:colorConst.grey1,
                                            borderRadius: BorderRadius.circular(w*0.06),
                                            border: Border.all(
                                                width: w*0.0003,
                                                color: colorConst.black.withOpacity(0.38)
                                            )
                                          ),
                                        child:Center(child: Icon(Icons.add,
                                            size:w*0.04)),
                                          ),
                                    )
                                  ],

                                ),
                              ],
                            ),
                            SizedBox(width: w*0.02,),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: w*0.03,);
                    },
                    ),
              ),
              SizedBox(height: w*0.04,),
              Text("Order Summary",
                style:TextStyle(
                  fontSize:w*0.05,
                  fontWeight:FontWeight.w700,
                  color: colorConst.meroon
                ),),
              SizedBox(height: w*0.02,),
              Text("Additional Note",
                style:TextStyle(
                  fontSize:w*0.04,
                  fontWeight:FontWeight.w700,
                  color: colorConst.black
                ),),
              SizedBox(height: w*0.02,),
              Container(
                height: w*0.3,
                decoration: BoxDecoration(
                  color: colorConst.white,
                  borderRadius: BorderRadius.circular(w*0.04),
                  border: Border.all(
                      width: w*0.0003,
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
                    contentPadding: EdgeInsets.only(left: w*0.05,right: w*0.05),
                    border:InputBorder.none,
                    hintText: "Any instruction regarding cuts",
                    hintStyle: TextStyle(
                      fontSize: w*0.04
                    )
                  ),
                ),
              ),
              SizedBox(height: w*0.05,),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Item Price",
                      style: TextStyle(
                        color: colorConst.black,
                        fontSize: w*0.04,
                        fontWeight: FontWeight.w500
                      ),),
                      Text("₹ 250.00",
                      style: TextStyle(
                        color: colorConst.black,
                        fontSize: w*0.04,
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
                        fontSize: w*0.04,
                        fontWeight: FontWeight.w500
                      ),),
                      Text("₹ 0.00",
                      style: TextStyle(
                        color: colorConst.black,
                        fontSize: w*0.04,
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
                        fontSize: w*0.04,
                        fontWeight: FontWeight.w500
                      ),),
                      Text("₹ 50.00",
                      style: TextStyle(
                        color: colorConst.black,
                        fontSize: w*0.04,
                        fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                  SizedBox(height: w*0.08,),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
