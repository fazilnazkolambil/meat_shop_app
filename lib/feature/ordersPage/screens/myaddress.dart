import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/main.dart';

class myaddress extends StatefulWidget {
  const myaddress({super.key});

  @override
  State<myaddress> createState() => _myaddressState();
}

class _myaddressState extends State<myaddress> {
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
              child: Center(child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                  child: SvgPicture.asset(iconConst.backarrow)))
          ),
        ),
        title: Text("My address",
          style: TextStyle(
              fontWeight: FontWeight.w600
          ),),
      ),
      body: Padding(
        padding:  EdgeInsets.all(scrWidth*0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: scrWidth*0.15,
              width: scrWidth*0.93,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                borderRadius: BorderRadius.circular(scrWidth*0.03)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(CupertinoIcons.plus),
                  Text("Add New Address"),
                ],
              ),
            ),
            SizedBox(height: scrWidth*0.05,),
            Container(
              height: scrWidth*0.5,
              width: scrWidth*0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(scrWidth*0.03),
                color: Colors.grey[300],
              ),

              child: Padding(
                padding: EdgeInsets.all(scrWidth*0.025),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                      Text("Name :"),
                      Text("///"),
                    ],
                    ),
                    Row(
                      children: [
                      Text("Address :"),
                      Text("///"),
                    ],
                    ),
                    Row(
                      children: [
                      Text("Pincode :"),
                      Text("///"),
                    ],
                    ),
                    Row(
                      children: [
                      Text("House Number :"),
                      Text("///"),
                    ],
                    ),
                    Row(
                      children: [
                      Text("Phone Number :"),
                      Text("///"),
                    ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {

                          },
                          child: Container(
                            height: scrWidth*0.1,
                            width: scrWidth*0.33,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(scrWidth*0.01),
                                color: Colors.grey[500]
                            ),
                            child: Center(child: Text("Edit")),
                          ),
                        ),
                        InkWell(
                          onTap: () {

                          },
                          child: Container(
                            height: scrWidth*0.1,
                            width: scrWidth*0.12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(scrWidth*0.01),
                                color: Colors.grey[500]
                            ),
                            child: Center(child: Icon(Icons.delete_outline,color: colorConst.meroon,)),
                          ),
                        ),
                        InkWell(
                          onTap: () {

                          },
                          child: Container(
                            height: scrWidth*0.1,
                            width: scrWidth*0.33,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(scrWidth*0.01),
                                color: Colors.grey[500]
                            ),
                            child: Center(child: Text("Default")),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
