import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/NavigationPage.dart';
import 'package:meat_shop_app/feature/ordersPage/screens/checkoutpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../ordersPage/screens/cart_page.dart';
import 'meatList.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search_controller = TextEditingController();
  List items = [];
  List filteredItems = [];
  List itemsCollection = [];
  List trending = [];
  bool loading = false;
  bool search = false;
  getItems() async {
    loading = true;
    setState(() {

    });
    var data = await FirebaseFirestore.instance.collection("meatTypes").get();
    for(int a = 0; a < data.size; a++){
      trending.add(data.docs[a]["type"]);
      var data1 = await FirebaseFirestore.instance.collection("meatTypes").doc(data.docs[a]["type"])
          .collection(data.docs[a]["type"]).get();
      for(int b = 0; b < data1.docs.length; b++){
        var data2 = await FirebaseFirestore.instance.collection("meatTypes").doc(data.docs[a]["type"])
            .collection(data.docs[a]["type"]).doc(data1.docs[b]["category"])
            .collection(data.docs[a]["type"]).get();
        for(int c = 0; c < data2.docs.length; c++){
          items.add({
            "name" : data2.docs[c]["name"],
            "Image" : data2.docs[c]["Image"],
            "description" : data2.docs[c]["description"],
            "id" : data2.docs[c]["id"],
            "ingredients" : data2.docs[c]["ingredients"],
            "rate" : data2.docs[c]["rate"],
            "quantity" : data2.docs[c]["quantity"],
            "category" : data2.docs[c]["category"],
            "type" : data2.docs[c]["type"],
          });
        }
      }
    }
    loading = false;
    setState(() {

    });
  }
  List meatDetailCollection = [];
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
  void _search(String value) {
    setState(() {
      filteredItems = items.where((map) {
        return map['name'].toLowerCase().contains(value.toLowerCase());
      }).toList();
    });
  }


  @override
  void initState() {
    loadData();
    getItems();
    //filteredItems = items;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConst.white,
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
        title: Text('Search',style: TextStyle(
          fontSize: scrWidth*0.05,
          fontWeight: FontWeight.w600
        ),),
          centerTitle: true,
      ),
      body: loading?
          Center(child: Lottie.asset(gifs.loadingGif)):
      SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              //onChanged: (value) => _search(value),
              onChanged: (value) {
                _search(value);
                search = true;
                setState(() {
                  
                });
              },
              style: TextStyle(
                fontSize: scrWidth * 0.04,
                fontWeight: FontWeight.w400,
              ),
              controller: search_controller,
              decoration: InputDecoration(
                fillColor: colorConst.grey1,
                filled: true,
                constraints: BoxConstraints(
                  maxHeight: scrHeight*0.07,
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(scrWidth*0.029),
                  child: SvgPicture.asset(iconConst.search,
                  ),
                ),prefixIconConstraints: BoxConstraints(
                  maxHeight: scrWidth*0.1,
                  maxWidth: scrWidth*0.1
              ),
                hintText: "Search here for anything you want...",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: scrWidth * 0.04,
                    color: colorConst.grey),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(scrWidth * 0.09),
                    borderSide: BorderSide(color: colorConst.grey1)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(scrWidth * 0.09),
                    borderSide: BorderSide(color: colorConst.grey1)),
              ),
            ),

            SizedBox(
              height: scrHeight*0.8,
              child: search?
              filteredItems.isEmpty?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Lottie.asset(gifs.emptyCart,height: scrHeight*0.3)),
                      Center(child: Text("No items Found")),
                      SizedBox(height: scrHeight*0.03,),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.all(scrWidth*0.03),
                        child: Text("Trending Searches",style: TextStyle(
                          fontWeight: FontWeight.w600
                        ),),
                      ),
                      SizedBox(
                        height:scrHeight*0.3,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MeatListPage(type: trending[index]),));
                                },
                                child: ListTile(
                                  leading: Icon(Icons.trending_up),
                                  title: Text(trending[index]),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(),
                            itemCount: trending.length
                        ),
                      )
                    ],
                  ):
              //Text("No Items Found"):
              ListView.builder(
                shrinkWrap: true,
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> map = filteredItems[index];
                  return
                    InkWell(
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
                                                  image: NetworkImage(map["Image"]), fit: BoxFit.fill))),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            map["name"],
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
                                                "₹ ${map["rate"]}", style: TextStyle(
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
                                    map["description"],
                                    style: TextStyle(
                                        color: colorConst.black
                                            .withOpacity(0.4)),
                                  ),
                                  Divider(),
                                  addCart.contains(map["id"])?
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
                                          if(addCart.contains(map["id"])){
                                            addCart.remove(map["id"]);
                                            meatDetailCollection.removeWhere((element) => element["id"] == map["id"]);
                                            saveData();
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item removed from the Cart!")));
                                          }else{
                                            addCart.add(map["id"]);
                                            meatDetailCollection.add({
                                              "category" : map['category'],
                                              "type" : map['type'],
                                              "id" : map["id"],
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
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(map['Image']),
                        ),
                          title: Text(map['name']),
                        subtitle: Text('₹ ${map['rate'].toString()}.00'),
                      ));
                },
              )
                  :ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MeatListPage(type: trending[index]),));
                      },
                      child: ListTile(
                        leading: Icon(Icons.trending_up),
                        title: Text(trending[index]),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(),
                  itemCount: trending.length
              )
            )

          ],
        ),
      ),
    );
  }
}
