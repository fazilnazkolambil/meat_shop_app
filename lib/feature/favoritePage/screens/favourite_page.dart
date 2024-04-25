import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../authPage/screens/info_page.dart';
import '../../authPage/screens/signin_page.dart';
import '../../homePage/screens/meatList.dart';
import '../../onboardPage/screens/NavigationPage.dart';
import '../../ordersPage/screens/cart_page.dart';


class favouritePage extends StatefulWidget {
  const favouritePage({super.key});

  @override
  State<favouritePage> createState() => _favouritePageState();
}

class _favouritePageState extends State<favouritePage> {
  List meatDetailCollection = [];
  Future <void> saveData () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(meatDetailCollection);
    String jsonString2 = json.encode(meatDetailCollection);
    prefs.setString('cart', jsonString);
    prefs.setString('cart2', jsonString2);
  }
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
@override
  void initState() {
    loadData();
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConst.white,
      appBar: AppBar(
        backgroundColor: colorConst.white,
        leading: SizedBox(),
        leadingWidth: 0,
        title: Text("Favourite",
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => cartPage(),));
              },
              child: addCart.isEmpty?
              SvgPicture.asset(iconConst.cart):
              SizedBox(
                height: scrWidth*0.08,
                width: scrWidth*0.08,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: scrWidth*0.03,
                      left: scrWidth*0.03,
                      child: CircleAvatar(
                        backgroundColor: colorConst.meroon,
                        radius: scrWidth*0.025,
                        child: Center(
                          child: Text(addCart.length.toString(),style: TextStyle(
                              color: colorConst.white,
                              fontWeight: FontWeight.w600,
                              fontSize: scrWidth*0.03
                          ),),
                        ),
                      ),
                    ),
                    Positioned(
                        left: 0,
                        bottom: 0,
                        child: SvgPicture.asset(iconConst.cart,)),
                  ],
                ),
              )),
          SizedBox(width: scrWidth*0.04,),
          SvgPicture.asset(iconConst.notification),
          SizedBox(width: scrWidth*0.04,),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.all(scrWidth*0.04),
        child:loginId == ""?
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Lottie.asset(gifs.login),
            Text("Please Login to view your Favourites and access all offers and services!",textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: scrWidth*0.04
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => infoPage(path: '',),));
                  },
                  child: Container(
                    height: scrHeight*0.05,
                    width: scrWidth*0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(scrWidth*0.03),
                        border: Border.all(color: colorConst.meroon)
                    ),
                    child: Center(child: Text("Sign Up"),),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => signinPage(path: '',),));
                  },
                  child: Container(
                    height: scrHeight*0.05,
                    width: scrWidth*0.4,
                    decoration: BoxDecoration(
                        color: colorConst.meroon,
                        borderRadius: BorderRadius.circular(scrWidth*0.03),
                        border: Border.all(color: colorConst.meroon)
                    ),
                    child: Center(child: Text("Log In",style: TextStyle(
                        color: colorConst.white
                    ),),),
                  ),
                ),
              ],
            )
          ],
        ):
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("users").doc(loginId).snapshots(),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData) {
                      return Lottie.asset(gifs.loadingGif);
                    }
                    var data = snapshot.data!['favourites'];
                    return data.isEmpty?
                    SizedBox(
                      height: scrHeight*0.8,
                      width: scrWidth*1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Lottie.asset(gifs.emptyCart),
                          Text("Your Favourite list is Empty!",style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: scrWidth*0.04
                          )),
                          InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => NavigationPage(),), (route) => false);
                            },
                            child: Container(
                              height: scrWidth*0.15,
                              width: scrWidth*0.9,
                              decoration: BoxDecoration(
                                color: colorConst.meroon,
                                borderRadius: BorderRadius.circular(scrWidth*0.05),
                              ),
                              child: Center(child: Text("Add Items",
                                style: TextStyle(
                                    color: colorConst.white
                                ),)),
                            ),
                          )

                        ],
                      ),
                    )
                        :ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: colorConst.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(scrWidth * 0.07),
                                    topRight: Radius.circular(scrWidth * 0.07),
                                  )),
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.all(scrWidth * 0.06),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                              height: scrWidth * 0.34,
                                              width: scrWidth * 0.34,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(scrWidth * 0.04),
                                                  border: Border.all(
                                                      width: scrWidth * 0.0003,
                                                      color: colorConst.black.withOpacity(0.38)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(data[index]["Image"]), fit: BoxFit.fill)
                                              )),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data[index]["name"],
                                                style: TextStyle(
                                                    fontSize: scrWidth * 0.04,
                                                    fontWeight: FontWeight.w700,
                                                    color: colorConst.black),
                                              ),
                                              Row(

                                                children: [
                                                  Text(
                                                    "1 KG - ", style: TextStyle(
                                                      fontSize: scrWidth * 0.04,
                                                      fontWeight: FontWeight.w700,
                                                      color: colorConst.black),
                                                  ),
                                                  Text(
                                                    "₹ ${data[index]["rate"]}", style: TextStyle(
                                                      fontSize: scrWidth * 0.04,
                                                      fontWeight: FontWeight.w700,
                                                      color: colorConst.meroon),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                      Text(
                                        data[index]["description"],
                                        style: TextStyle(
                                            color: colorConst.black
                                                .withOpacity(0.4)),
                                      ),
                                      Divider(),
                                      addCart.contains(data[index]["id"])?
                                      InkWell(
                                        onTap: () {
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => checkoutpage(id: '',),));
                                        },
                                        child: Container(
                                          height: scrWidth*0.15,
                                          width: scrWidth*0.9,
                                          decoration: BoxDecoration(
                                            color: colorConst.meroon,
                                            borderRadius: BorderRadius.circular(scrWidth*0.05),
                                          ),
                                          child: Center(child: Text("Go to Cart",
                                            style: TextStyle(
                                                color: colorConst.white
                                            ),)),
                                        ),
                                      )
                                          :Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: scrHeight*0.05,
                                            width: scrWidth*0.4,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(scrWidth*0.03),
                                                border: Border.all(color: colorConst.meroon)
                                            ),
                                            child: Center(child: Text("Buy Now"),),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if(addCart.contains(data[index]["id"])){
                                                addCart.remove(data[index]["id"]);
                                                meatDetailCollection.remove(meatDetailCollection[index]);
                                              }else{
                                                addCart.add(data[index]["id"]);
                                                meatDetailCollection.add({
                                                  "Image" : data[index]["Image"],
                                                  "name" : data[index]["name"],
                                                  "ingredients" : data[index]["ingredients"],
                                                  "rate" : data[index]["rate"],
                                                  "quantity" : 1
                                                });
                                              }
                                              Navigator.pop(context);
                                              setState(() {

                                              });
                                            },
                                            child: Container(
                                              height: scrHeight*0.05,
                                              width: scrWidth*0.4,
                                              decoration: BoxDecoration(
                                                  color: colorConst.meroon,
                                                  borderRadius: BorderRadius.circular(scrWidth*0.03),
                                                  border: Border.all(color: colorConst.meroon)
                                              ),
                                              child: Center(child: Text("Add to Cart",style: TextStyle(
                                                  color: colorConst.white
                                              ),),),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: scrWidth * 0.35,
                            padding: EdgeInsets.all(scrWidth*0.03),
                            decoration: BoxDecoration(
                              color: colorConst.white,
                              borderRadius: BorderRadius.circular(scrWidth * 0.04),
                              border: Border.all(
                                  width: scrWidth * 0.0003,
                                  color: colorConst.black.withOpacity(0.38)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                Container(
                                    height: scrWidth * 0.27,
                                    width: scrWidth * 0.27,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(scrWidth * 0.04),
                                        border: Border.all(
                                            width: scrWidth * 0.0003,
                                            color: colorConst.black.withOpacity(0.38)),
                                        image: DecorationImage(
                                            image: NetworkImage(data[index]["Image"]), fit: BoxFit.fill))),
                                SizedBox(
                                  width: scrWidth * 0.02,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: scrWidth * 0.4,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index]["name"],
                                            style: TextStyle(
                                                fontSize: scrWidth * 0.04,
                                                fontWeight: FontWeight.w700,
                                                color: colorConst.black),
                                          ),
                                          Text(data[index]["ingredients"],style: TextStyle(fontSize: scrWidth*0.03),),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          " 1 KG - ",
                                          style: TextStyle(
                                              fontSize: scrWidth * 0.04,
                                              fontWeight: FontWeight.w700,
                                              color: colorConst.black),
                                        ),
                                        Text(
                                          "₹ ${data[index]["rate"]}",
                                          style: TextStyle(
                                              fontSize: scrWidth * 0.04,
                                              fontWeight: FontWeight.w700,
                                              color: colorConst.meroon),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text("Are you sure you want to remove this item from Favourites?",
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
                                                          "favourites":FieldValue.arrayRemove([data[index]])
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

                                        child:
                                        Icon(
                                          Icons.favorite,
                                          color:colorConst.meroon,
                                          size: scrWidth*0.08,
                                        )
                                    ),
                                    InkWell(
                                        onTap: () {
                                          if(addCart.contains(data[index]["id"])){
                                            addCart.remove(data[index]["id"]);
                                            meatDetailCollection.remove(meatDetailCollection[index]);
                                          }else{
                                            addCart.add(data[index]["id"]);
                                            meatDetailCollection.add({
                                              "Image" : data[index]["Image"],
                                              "name" : data[index]["name"],
                                              "ingredients" : data[index]["ingredients"],
                                              "rate" : data[index]["rate"],
                                              "quantity" : 1
                                            });
                                          }
                                          setState(() {

                                          });
                                        },
                                        child:
                                        addCart.contains(data[index]["id"])?
                                        Icon(Icons.done,color: colorConst.green)
                                            :CircleAvatar(
                                          radius: scrWidth*0.04,
                                          backgroundColor: colorConst.meroon,
                                          child: Icon(
                                            Icons.add,
                                            color: colorConst.white,
                                            size: scrWidth * 0.04,
                                          ),
                                        )
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: scrWidth * 0.02,
                                ),
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
      ),
    );
  }
}
