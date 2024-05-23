
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/authPage/screens/info_page.dart';
import 'package:meat_shop_app/feature/homePage/repository/homePageProviders.dart';
import 'package:meat_shop_app/feature/homePage/screens/HomePage.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/NavigationPage.dart';
import 'package:meat_shop_app/feature/ordersPage/screens/cart_page.dart';
import 'package:meat_shop_app/feature/ordersPage/screens/checkoutpage.dart';
import 'package:meat_shop_app/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../authPage/screens/signin_page.dart';
List addCart=[];

class MeatListPage extends ConsumerStatefulWidget {
  final String type;
  const MeatListPage({
    super.key,
    required this.type,
  });

  @override
  ConsumerState<MeatListPage> createState() => _MeatListPageState();
}

TextEditingController emailController = TextEditingController();
class _MeatListPageState extends ConsumerState<MeatListPage> {
  int selectedIndex = 0;
  String selectedCategory = '';
  String? category;
  int count = 1;

  List meatDetailCollection = [];
  List categoryCollection = [];
  List fav=[];
  List favoriteList =[];

  getMeats() async {
    var category = await FirebaseFirestore.instance
        .collection("meatTypes")
        .doc(widget.type)
        .collection(widget.type)
        .get();
    categoryCollection = category.docs;

    setState(() {});
  }

  // getMeatDetails() async {
  //   var meatDetails = await FirebaseFirestore.instance
  //       .collection("meatTypes")
  //       .doc(widget.type)
  //       .collection(widget.type)
  //       .doc(selectedCategory)
  //       .collection(widget.type)
  //       .get();
  //   meatDetailCollection = meatDetails.docs;
  //   setState(() {
  //
  //   });
  // }
  bool login = false;
  String? loginId;
  UserModel? usermodel;
  Map favFB = {};
  getData () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    login = prefs.getBool("LoggedIn") ?? false;
    loginId = prefs.getString("loginUserId") ?? "";
    var data = await FirebaseFirestore.instance.collection("users").doc(loginId).get();
    favFB = data.data()!;
    favoriteList=favFB['favourites'];
    for(int i=0;i<favoriteList.length;i++){
      fav.add(favFB["favourites"][i]["id"]);
    }
    setState(() {

    });
  }
  Future <void> saveData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(meatDetailCollection);
    String jsonString2 = json.encode(addCart);
    prefs.setString("cart", jsonString);
    prefs.setString("cart2", jsonString2);
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
  String? address;
  getAddress () async {
    try{
      Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
      List <Placemark> result = await placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);
      Placemark first = result.first;
      setState(() {
        address = "${first.locality}, ${first.administrativeArea}";
      });
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to load your Location")));
    }
  }
  @override
  void initState() {
    getMeats();
    getData();
    loadData();
    getAddress();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorConst.white,
        bottomNavigationBar: addCart.isEmpty? SizedBox()
            :SizedBox(
          height: scrHeight*0.12,
          child: Padding(
            padding:  EdgeInsets.all(scrWidth*0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => cartPage()));
                  },
                  child: Container(
                    height: scrWidth*0.12,
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
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: colorConst.white,
          leading: Padding(
            padding:EdgeInsets.all(scrWidth*0.03),
            child: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => NavigationPage(),), (route) => false);
              },
              child: CircleAvatar(
                  backgroundColor: colorConst.grey1,
                  child: Center(child: SvgPicture.asset(iconConst.backarrow))),
            ),
          ),
          title: Row(
            children: [
              SvgPicture.asset(iconConst.location),
              SizedBox(
                width: scrWidth * 0.02,
              ),
              Text(address == null? "Fetching your location...":
              "$address",
                style: TextStyle(
                    fontSize: scrWidth * 0.04, color: colorConst.black),
              )
            ],
          ),
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
            SizedBox(
              width: scrWidth * 0.04,
            ),
            SvgPicture.asset(iconConst.notification),
            SizedBox(
              width: scrWidth * 0.03,
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(scrWidth * 0.05),
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.type}",
                      style: TextStyle(
                          fontSize: scrWidth * 0.07,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: scrWidth * 0.02,
                    ),
                    SizedBox(
                        height: scrHeight * 0.05,
                        width: scrWidth * 1,
                        child: ListView.separated(
                            itemCount: categoryCollection.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  selectedIndex = index;
                                  selectedCategory =
                                  categoryCollection[index]["category"];
                                  setState(() {});
                                },
                                child: Container(
                                  height: scrHeight * 0.05,
                                  padding: EdgeInsets.only(
                                      left: scrWidth * 0.04,
                                      right: scrWidth * 0.04),
                                  child: Center(
                                    child: Text(
                                      categoryCollection[index]["category"],
                                      // data[index]["category"],
                                      style: TextStyle(
                                          color: selectedIndex == index
                                              ? colorConst.white
                                              : colorConst.black.withOpacity(0.5),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(scrWidth * 0.05),
                                      color: selectedIndex == index
                                          ? colorConst.meroon
                                          : colorConst.white,
                                      border: Border.all(
                                        color: selectedIndex == index
                                            ? colorConst.meroon
                                            : colorConst.black.withOpacity(0.5),
                                      )),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: scrWidth * 0.02,
                              );
                            })),
                    SizedBox(
                      height: scrWidth * 0.05,
                    ),
                    SizedBox(
                      height: addCart.isEmpty?scrHeight*0.7:scrHeight*0.6,
                      width: scrWidth*1,
                      child:categoryCollection.isEmpty?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              height: scrHeight*0.15,
                              child: Lottie.asset(gifs.comingSoon)),
                          Text("${widget.type} will be available Soon!",style: TextStyle(
                              fontSize: scrWidth*0.05,
                              fontWeight: FontWeight.w700,
                              color: colorConst.meroon
                          ),)
                        ],
                      )
                          : StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
                          stream:selectedCategory == ""?
                          FirebaseFirestore.instance.collection("meatTypes").doc(widget.type)
                              .collection(widget.type).doc(categoryCollection[0]["category"])
                              .collection(widget.type).snapshots()
                              :FirebaseFirestore.instance.collection("meatTypes").doc(widget.type)
                              .collection(widget.type).doc(selectedCategory)
                              .collection(widget.type).snapshots(),
                          builder: (context, snapshot) {
                            if(!snapshot.hasData) {
                              return Lottie.asset(gifs.loadingGif);
                            }
                            var data = snapshot.data!.docs;
                            return data.isEmpty?
                            Center(child: Text("No Meats Available right now!")):
                            ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
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
                                                              image: NetworkImage(data[index]["Image"]), fit: BoxFit.fill))),
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
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => cartPage(),));
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
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>checkoutpage(price: 0, discount: 0, shippingCharge: 0, subtotal: 0, cartMeat: [],) ,));
                                                    },
                                                    child: Container(
                                                      height: scrHeight*0.05,
                                                      width: scrWidth*0.4,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(scrWidth*0.03),
                                                          border: Border.all(color: colorConst.meroon)
                                                      ),
                                                      child: Center(child: Text("Buy Now"),),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      if(addCart.contains(data[index]["id"])){
                                                        addCart.remove(data[index]["id"]);
                                                        meatDetailCollection.removeWhere((element) => element["id"]==data[index]["id"]);
                                                        saveData();
                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item removed from the Cart!")));
                                                      }else{
                                                        addCart.add(data[index]["id"]);
                                                        meatDetailCollection.add({
                                                          "category" : selectedCategory == ""?categoryCollection[0]["category"]:selectedCategory,
                                                          "type" : widget.type,
                                                          "id" : data[index]["id"],
                                                        });
                                                        saveData();
                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item added to the Cart!")));
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
                                    //padding: EdgeInsets.all(scrWidth*0.03),
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
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap:(){
                                                HapticFeedback.lightImpact();
                                                if(loginId!.isNotEmpty){
                                                  if(fav.contains(data[index]["id"])){
                                                    fav.remove(data[index]["id"]);
                                                    favoriteList.removeWhere((element) => element["id"] == data[index]["id"]);
                                                    FirebaseFirestore.instance.collection("users").doc(loginId).update({
                                                      "favourites" : favoriteList
                                                    });
                                                    setState(() {

                                                    });
                                                  }else{
                                                    fav.add(data[index]["id"]);
                                                    favoriteList.add({
                                                      "Image" : data[index]["Image"],
                                                      "name" : data[index]["name"],
                                                      "ingredients" : data[index]["ingredients"],
                                                      "rate" : data[index]["rate"],
                                                      "id" : data[index]["id"],
                                                      "description" : data[index]["description"],
                                                      "category" : selectedCategory == ""?categoryCollection[0]["category"]:selectedCategory,
                                                      "type" : widget.type,
                                                    });
                                                    FirebaseFirestore.instance.collection("users").doc(loginId).update({
                                                      "favourites" : FieldValue.arrayUnion(favoriteList)
                                                    });
                                                    setState(() {

                                                    });
                                                  }
                                                }else{
                                                  showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) {
                                                      return BottomSheet(
                                                        onClosing: () {

                                                        },
                                                        builder: (context) {
                                                          return Container(
                                                            height: scrHeight*0.2,
                                                            width: scrWidth*1,
                                                            margin: EdgeInsets.all(scrWidth*0.05),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text("Let's get you in!",style: TextStyle(
                                                                    fontWeight: FontWeight.w700,
                                                                    fontSize: scrWidth*0.05
                                                                ),),
                                                                Text("In just a minute, you can access all our offers, services and more.",
                                                                  textAlign: TextAlign.center,),
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
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );

                                                }
                                                setState(() {

                                                });

                                              },
                                              child: Icon(
                                                Icons.favorite,
                                                color:fav.contains(data[index]["id"])?
                                                colorConst.meroon:colorConst.grey,
                                                size: scrWidth*0.08,
                                              ),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  HapticFeedback.lightImpact();
                                                  if(addCart.contains(data[index]["id"])){
                                                    addCart.remove(data[index]["id"]);
                                                    meatDetailCollection.removeWhere((list) => list["id"]==data[index]["id"]);
                                                    saveData();
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item removed from the Cart!")));
                                                  }else{
                                                    addCart.add(data[index]["id"]);
                                                    meatDetailCollection.add({
                                                      "category" : selectedCategory == ""?categoryCollection[0]["category"]:selectedCategory,
                                                      "type" : widget.type,
                                                      "id" : data[index]["id"],
                                                    });
                                                    saveData();
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item added to the Cart!")));
                                                  }
                                                  setState(() {

                                                  });
                                                },
                                                child:
                                                addCart.contains(data[index]["id"])?
                                                 Icon(Icons.done,color: colorConst.green)
                                                // Container(
                                                //   padding: EdgeInsets.only(left: scrWidth*0.01,right: scrWidth*0.01),
                                                //   decoration:BoxDecoration(
                                                //     borderRadius: BorderRadius.circular(scrWidth*0.01),
                                                //     border: Border.all(color: colorConst.meroon)
                                                //   ),
                                                //   child: Row(children: [
                                                //     Icon(Icons.remove,
                                                //       color: colorConst.meroon,
                                                //       size: scrWidth*0.05,
                                                //     ),
                                                //     Text("${data[index]["quantity"]}",style: TextStyle(
                                                //       fontWeight: FontWeight.w600
                                                //     ),),
                                                //     Icon(Icons.add,
                                                //       color: colorConst.meroon,
                                                //       size: scrWidth*0.05,
                                                //     ),
                                                //   ],),
                                                // )
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
                              separatorBuilder: (BuildContext context, int index) {
                                return SizedBox(height: scrHeight*0.02,);
                              },
                            );
                          }
                      ),
                    )
                  ])),
        ));
  }
}