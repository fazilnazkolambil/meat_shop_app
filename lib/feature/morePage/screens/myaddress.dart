
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  //int Defaultt=-1;

  var userData;
  List addressData = [];
  userAddress () async {
    addressData.clear();
    for (int i = 0;i < userData["address"].length;i++){
       addressData.add(userData["address"][i]["type"]);
    }
  }
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
                userAddress();
                //print(addressData);
                Navigator.push(context, MaterialPageRoute(builder: (context) => addnewaddress(
                  userName: userData['name'],
                  userNumber: userData['number'],
                  types: addressData,
                ),));
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
                  userData = snapshot.data!.data();

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
                        width: scrWidth*0.9,
                        decoration: BoxDecoration(
                          color: colorConst.white,
                          borderRadius: BorderRadius.circular(scrWidth * 0.04),
                          border:Border.all(
                              width: scrWidth * 0.008,
                              color: colorConst.meroon)
                        ),

                        child: Padding(
                          padding: EdgeInsets.all(scrWidth*0.025),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: scrWidth*0.1,
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(scrWidth*0.02),
                                      border:Border.all(
                                          width: scrWidth * 0.004,
                                          color: colorConst.meroon)
                                    ),
                                    child: Center(child: Text(data[index]['type'],style: TextStyle(
                                      color: colorConst.meroon,
                                      fontWeight: FontWeight.bold
                                    ),)),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          userAddress();
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => editaddress(
                                            name: data[index]['name'],
                                            deliveryinstruction: data[index]['deliveryInstruction'],
                                            location: data[index]['location'],
                                            number: data[index]['number'],
                                            pincode: data[index]['pincode'],
                                            street: data[index]['street'],
                                            town: data[index]['town'],
                                            buildingName: data[index]['buildingName'],
                                            index: index,
                                            type: data[index]['type'],
                                            types: addressData,
                                          ),));
                                        },
                                        child: Container(
                                          height: scrWidth*0.1,
                                          width: scrWidth*0.12,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(scrWidth*0.01),
                                              color: colorConst.grey1
                                          ),
                                          child: Center(child: Icon(Icons.edit,color: colorConst.green,)),
                                        ),
                                      ),
                                      SizedBox(width: scrWidth*0.03,),
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
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: scrWidth*0.03),
                              Row(
                                children: [
                                  Text("Name : ",style: TextStyle(
                                    color: colorConst.meroon,
                                    fontWeight: FontWeight.w600,
                                    fontSize: scrWidth*0.04
                                  )),
                                  Text(data[index]["name"],style: TextStyle(
                                      color: colorConst.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: scrWidth*0.04
                                  )),
                                ],
                              ),
                              SizedBox(height: scrWidth*0.03,),
                              Row(
                                children: [
                                  Text("Location : ",style: TextStyle(
                                      color: colorConst.meroon,
                                      fontWeight: FontWeight.w600,
                                      fontSize: scrWidth*0.04
                                  )),
                                  SizedBox(
                                    width: scrWidth*0.6,
                                      child: Text("${data[index]["buildingName"]},${data[index]["street"]},${data[index]["town"]}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                          color: colorConst.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: scrWidth*0.04
                                      ))),
                                ],
                              ),
                              SizedBox(height: scrWidth*0.03,),
                              Row(
                                children: [
                                  Text("Pincode : ",style: TextStyle(
                                      color: colorConst.meroon,
                                      fontWeight: FontWeight.w600,
                                      fontSize: scrWidth*0.04
                                  )),
                                  Text(data[index]["pincode"],style: TextStyle(
                                      color: colorConst.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: scrWidth*0.04
                                  )),
                                ],
                              ),
                              SizedBox(height: scrWidth*0.03,),
                              Row(
                                children: [
                                  Text("Phone Number : ",style: TextStyle(
                                      color: colorConst.meroon,
                                      fontWeight: FontWeight.w600,
                                      fontSize: scrWidth*0.04
                                  )),
                                  Text(data[index]["number"],style: TextStyle(
                                      color: colorConst.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: scrWidth*0.04
                                  )),
                                ],
                              ),
                              SizedBox(height: scrWidth*0.03,),
                              Row(
                                children: [
                                  Text("Instructions : ",style: TextStyle(
                                      color: colorConst.meroon,
                                      fontWeight: FontWeight.w600,
                                      fontSize: scrWidth*0.04
                                  )),
                                  SizedBox(
                                      width: scrWidth*0.6,
                                      child: Text("${data[index]["deliveryInstruction"]}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: colorConst.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: scrWidth*0.04
                                          ))),
                                ],
                              ),
                              SizedBox(height: scrWidth*0.03,),
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
