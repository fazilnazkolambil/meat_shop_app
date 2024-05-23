import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/morePage/screens/addnewaddress.dart';
import 'package:meat_shop_app/main.dart';

import '../../onboardPage/screens/NavigationPage.dart';
import 'editaddress.dart';

class myaddress extends StatefulWidget {
  const myaddress({super.key});

  @override
  State<myaddress> createState() => _myaddressState();
}

class _myaddressState extends State<myaddress> {
  int Defaultt=-1;
  @override
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
        title: Text("My address",
          style: TextStyle(
              fontWeight: FontWeight.w600
          ),),
      ),
      body: Padding(
        padding:  EdgeInsets.all(scrWidth*0.03),
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => addnewaddress(),));
              },
              child: Container(
                height: scrWidth*0.15,
                width: scrWidth*0.93,
                decoration: BoxDecoration(
                    color: colorConst.meroon,
                  borderRadius: BorderRadius.circular(scrWidth*0.03)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(CupertinoIcons.plus,color: colorConst.white,),
                    Text("Add New Address",style: TextStyle(color: colorConst.white),),
                  ],
                ),
              ),
            ),
            SizedBox(height: scrWidth*0.05,),
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection("users").doc(loginId).snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) {
                    return Lottie.asset(gifs.loadingGif);
                  }
                  var data = snapshot.data!['address'];
                  return data.isEmpty?
                  SizedBox(
                    height: scrHeight*0.6,
                    width: scrWidth*1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("There is no address added!",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: scrWidth*0.04
                        )),

                      ],
                    ),
                  )
                      :ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: scrWidth*0.53,
                        width: scrWidth*0.9,
                        decoration: BoxDecoration(
                          color: colorConst.white,
                          borderRadius: BorderRadius.circular(scrWidth * 0.04),
                          border:Defaultt == index?
                          Border.all(
                              width: scrWidth * 0.008,
                              color: colorConst.meroon):
                          Border.all(
                              width: scrWidth * 0.002,
                              color: colorConst.grey),
                        ),

                        child: Padding(
                          padding: EdgeInsets.all(scrWidth*0.025),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("Name : "),
                                  Text(data[index]["name"]),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Address : "),
                                  Text(data[index]["address"]),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Pincode : "),
                                  Text(data[index]["pincode"]),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("House Number : "),
                                  Text(data[index]["houseno"]),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Landmark : "),
                                  Text(data[index]["landmark"]),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Phone Number : "),
                                  Text(data[index]["number"]),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => editaddress(
                                        id: loginId,
                                        address: '${data[index]["address"]}',
                                        pincode: data[index]["pincode"],
                                        houseno: data[index]["houseno"],
                                        phonenumber: data[index]["number"],
                                        name: data[index]["name"],
                                        landmark: data[index]["landmark"],
                                        index: index,
                                      ),));
                                    },
                                    child: Container(
                                      height: scrWidth*0.1,
                                      width: scrWidth*0.33,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(scrWidth*0.02),
                                          // color: colorConst.grey1,
                                          border:Defaultt == index?
                                      Border.all(
                                      width: scrWidth * 0.004,
                                          color: colorConst.meroon):
                                        Border.all(
                                        width: scrWidth * 0.002,
                                        color: colorConst.grey),
                                      ),
                                      child: Center(child: Text("Edit")),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Are you sure you want to remove this address?",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: scrWidth*0.04,
                                                  fontWeight: FontWeight.w600
                                              ),),
                                            content: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: scrWidth*0.08,
                                                    width: scrWidth*0.2,
                                                    decoration: BoxDecoration(
                                                      color: colorConst.textgrey,
                                                      borderRadius: BorderRadius.circular(scrWidth*0.03),
                                                    ),
                                                    child: Center(child: Text("No",
                                                      style: TextStyle(
                                                          color: Colors.white
                                                      ),)),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                    await FirebaseFirestore.instance.collection("users").doc(loginId).update({
                                                      "address":FieldValue.arrayRemove([data[index]])
                                                    });

                                                  },
                                                  child: Container(
                                                    height: scrWidth*0.08,
                                                    width: scrWidth*0.2,
                                                    decoration: BoxDecoration(
                                                      color: colorConst.meroon,
                                                      borderRadius: BorderRadius.circular(scrWidth*0.03),
                                                    ),
                                                    child: Center(child: Text("Yes",
                                                      style: TextStyle(
                                                          color: Colors.white
                                                      ),)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: scrWidth*0.1,
                                      width: scrWidth*0.12,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(scrWidth*0.01),
                                          color: colorConst.grey1
                                      ),
                                      child: Center(child: Icon(Icons.delete_outline,color: colorConst.meroon,)),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        Defaultt=index;
                                      });
                                    },
                                    child: Container(
                                      height: scrWidth*0.1,
                                      width: scrWidth*0.33,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(scrWidth*0.02),
                                          // color: colorConst.grey1,
                                        border:Defaultt == index?
                                        Border.all(
                                            width: scrWidth * 0.004,
                                            color: colorConst.meroon):
                                        Border.all(
                                            width: scrWidth * 0.002,
                                            color: colorConst.grey),
                                      ),
                                      child: Center(child:  Text(Defaultt == index?"Default":"Set as Default")),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: scrWidth*0.03,);
                    },
                  );
                }
            ),


          ],
        ),
      ),
    );
  }
}
