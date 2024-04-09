import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/authPage/screens/signin_page.dart';

import '../../../main.dart';
import 'checkoutpage.dart';

class cartPage extends StatefulWidget {
  const cartPage({super.key, required this.cartItems});
  final List cartItems;
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
          padding:  EdgeInsets.all(scrWidth*0.03),
          child: Container(
              decoration: BoxDecoration(
                color: colorConst.grey1,
                borderRadius: BorderRadius.circular(scrWidth*0.08)
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
          SizedBox(width: scrWidth*0.04,),
          Container(child: SvgPicture.asset(iconConst.notification)),
          SizedBox(width: scrWidth*0.03,),
        ],
      ),
      bottomNavigationBar:InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => signinPage(),));
        },
        child: Container(
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
                    Text("₹ 300.00",
                      style: TextStyle(
                          color: colorConst.meroon,
                          fontSize: scrWidth*0.05,
                          fontWeight: FontWeight.w700
                      ),)
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => checkoutpage(id: '',),));
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
      ),
      body: Padding(
        padding:  EdgeInsets.all(scrWidth*0.028),
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
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      var item=widget.cartItems[index];
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
                                image: DecorationImage(image: AssetImage(item["image"]),fit: BoxFit.fill))
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
                                      Text( item["name"],
                                        style: TextStyle(
                                            fontSize: scrWidth*0.035,
                                            fontWeight: FontWeight.w700,
                                            color: colorConst.black
                                        ),),
                                      Text(item["description"],style: TextStyle(
                                        fontSize: scrWidth*0.03
                                      ),),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("1 KG - ",
                                      style: TextStyle(
                                          fontSize: scrWidth*0.035,
                                          fontWeight: FontWeight.w700,
                                          color: colorConst.black
                                      ),),
                                    Text("₹ ${item["rate"]}",
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
                                Container(
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
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        count<=0? 0:count--;
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
                                    Text(count.toString(),
                                      style: TextStyle(
                                        fontSize: scrWidth*0.04,
                                        fontWeight: FontWeight.w600
                                      ),),
                                    SizedBox(width: scrWidth*0.015,),
                                    InkWell(
                                      onTap: () {
                                        count++;
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
                      Text("₹ 250.00",
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
