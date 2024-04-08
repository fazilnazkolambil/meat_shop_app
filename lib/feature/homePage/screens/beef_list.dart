import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';

import '../../../main.dart';

class BeefList extends StatefulWidget {
  final String type;
  const BeefList({super.key, required this.type,});


  @override
  State<BeefList> createState() => _BeefListState();
}

class _BeefListState extends State<BeefList> {
  int selectIndex = -1;
  String selectCategory = '';
  int count = 1;
  getMeats() async {
    var Meats = await FirebaseFirestore.instance.collection("meats").snapshots();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(scrWidth * 0.03),
              child: Container(
                  decoration: BoxDecoration(
                      color: colorConst.grey1,
                      borderRadius: BorderRadius.circular(scrWidth * 0.08)),
                  child: Center(
                      child: SvgPicture.asset(iconConst.backarrow))),
            ),
          ),
          title: Row(
            children: [
              SvgPicture.asset(iconConst.location),
              SizedBox(
                width: scrWidth * 0.02,
              ),
              Text(
                "Kuwait City, Kuwait",
                style: TextStyle(
                    fontSize: scrWidth * 0.04, color: colorConst.black),
              )
            ],
          ),
          actions: [
            SvgPicture.asset(iconConst.cart),
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
                  "Beef",
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
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("category")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Lottie.asset(gifs.loadingGif);
                          }
                          var data = snapshot.data!.docs;
                          return data.length == 0
                              ? Lottie.asset(gifs.loadingGif)
                              : ListView.separated(
                                  itemCount: data.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        selectIndex = index;
                                        selectCategory =
                                            data[index]["category"];
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: scrHeight * 0.05,
                                        padding: EdgeInsets.only(
                                            left: scrWidth * 0.04,
                                            right: scrWidth * 0.04),
                                        child: Center(
                                          child: Text(
                                            data[index]["category"],
                                            style: TextStyle(
                                                color: selectIndex == index
                                                    ? colorConst.black
                                                    : colorConst.black
                                                        .withOpacity(0.5),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                scrWidth * 0.05),
                                            color: selectIndex == index
                                                ? colorConst.yellow
                                                : colorConst.white,
                                            border: Border.all(
                                              color: selectIndex == index
                                                  ? colorConst.yellow
                                                  : colorConst.black
                                                      .withOpacity(0.5),
                                            )),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      width: scrWidth * 0.02,
                                    );
                                  },
                                );
                        })),
                SizedBox(
                  height: scrWidth * 0.05,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: selectCategory == ""
                        ? FirebaseFirestore.instance
                            .collection("meats").where('type',isEqualTo: widget.type)
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection('meats')
                        .where('type', isEqualTo: widget.type)
                        .where('category', isEqualTo: selectCategory)
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Lottie.asset(gifs.loadingGif);
                      }
                      var data = snapshot.data!.docs;
                      return data.length == 0
                          ? Center(child: Text("No Meats Found!"),)
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: scrWidth * 0.33,
                                  decoration: BoxDecoration(
                                      color: colorConst.white,
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.04),
                                      border: Border.all(
                                          width: scrWidth * 0.0003,
                                          color: colorConst.black
                                              .withOpacity(0.38)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: colorConst.black
                                                .withOpacity(0.1),
                                            blurRadius: 14,
                                            offset: Offset(0, 4),
                                            spreadRadius: 0)
                                      ]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: scrWidth * 0.02,
                                      ),
                                      Container(
                                          height: scrWidth * 0.27,
                                          width: scrWidth * 0.27,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      scrWidth * 0.04),
                                              border: Border.all(
                                                  width: scrWidth * 0.0003,
                                                  color: colorConst.black
                                                      .withOpacity(0.38)),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      data[index]["Image"]),
                                                  fit: BoxFit.fill))),
                                      SizedBox(
                                        width: scrWidth * 0.02,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: scrWidth * 0.4,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data[index]["name"],
                                                  style: TextStyle(
                                                      fontSize: scrWidth * 0.04,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: colorConst.black),
                                                ),
                                                Text(
                                                    data[index]["ingredients"]),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                              " ${data[index]["quantity"]} KG - ",
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          FavoriteButton(
                                            valueChanged: (_) {},
                                            iconSize: 39,
                                            iconColor: colorConst.meroon,
                                          ),
                                          // SvgPicture.asset(iconConst.Favourite,color: favourite.contains(index)?colorConst.meroon:colorConst.grey,),
                                          InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                backgroundColor:
                                                    colorConst.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                      scrWidth * 0.07),
                                                  topRight: Radius.circular(
                                                      scrWidth * 0.07),
                                                )),
                                                builder: (context) {
                                                  return Padding(
                                                    padding: EdgeInsets.all(
                                                        scrWidth * 0.06),
                                                    child: Container(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Container(
                                                                  height:
                                                                      scrWidth *
                                                                          0.34,
                                                                  width:
                                                                      scrWidth *
                                                                          0.34,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(scrWidth *
                                                                              0.04),
                                                                      border: Border.all(
                                                                          width: scrWidth *
                                                                              0.0003,
                                                                          color: colorConst.black.withOpacity(
                                                                              0.38)),
                                                                      image: DecorationImage(
                                                                          image:
                                                                              NetworkImage(data[index]["Image"]),
                                                                          fit: BoxFit.fill))),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                    width:
                                                                        scrWidth *
                                                                            0.37,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Text(
                                                                          data[index]
                                                                              [
                                                                              "name"],
                                                                          style: TextStyle(
                                                                              fontSize: scrWidth * 0.04,
                                                                              fontWeight: FontWeight.w700,
                                                                              color: colorConst.black),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        scrWidth *
                                                                            0.02,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        data[index]
                                                                            [
                                                                            "quantity"],
                                                                        style: TextStyle(
                                                                            fontSize: scrWidth *
                                                                                0.04,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            color: colorConst.black),
                                                                      ),
                                                                      Text(
                                                                        data[index]
                                                                            [
                                                                            "rate"],
                                                                        style: TextStyle(
                                                                            fontSize: scrWidth *
                                                                                0.04,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            color: colorConst.meroon),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            data[index]["description"],
                                                            style: TextStyle(
                                                                color: colorConst
                                                                    .black
                                                                    .withOpacity(
                                                                        0.4)),
                                                          ),
                                                          Divider(),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "₹  250.00",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        scrWidth *
                                                                            0.04,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: colorConst
                                                                        .meroon),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      count <= 0
                                                                          ? 0
                                                                          : count--;
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height: scrWidth *
                                                                          0.065,
                                                                      width: scrWidth *
                                                                          0.065,
                                                                      decoration: BoxDecoration(
                                                                          color: colorConst
                                                                              .grey1,
                                                                          borderRadius: BorderRadius.circular(scrWidth *
                                                                              0.06),
                                                                          border: Border.all(
                                                                              width: scrWidth * 0.0003,
                                                                              color: colorConst.black.withOpacity(0.38))),
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          size: scrWidth *
                                                                              0.04),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        scrWidth *
                                                                            0.015,
                                                                  ),
                                                                  Text(
                                                                    count
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            scrWidth *
                                                                                0.04,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        scrWidth *
                                                                            0.015,
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      count++;
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height: scrWidth *
                                                                          0.065,
                                                                      width: scrWidth *
                                                                          0.065,
                                                                      decoration: BoxDecoration(
                                                                          color: colorConst
                                                                              .grey1,
                                                                          borderRadius: BorderRadius.circular(scrWidth *
                                                                              0.06),
                                                                          border: Border.all(
                                                                              width: scrWidth * 0.0003,
                                                                              color: colorConst.black.withOpacity(0.38))),
                                                                      child: Center(
                                                                          child: Icon(
                                                                              Icons.add,
                                                                              size: scrWidth * 0.04)),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            height: scrHeight *
                                                                0.07,
                                                            width:
                                                                scrWidth * 0.9,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    colorConst
                                                                        .meroon,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        scrWidth *
                                                                            0.05)),
                                                            child: Center(
                                                              child: Text(
                                                                "Add To Cart",
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      colorConst
                                                                          .white,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: CircleAvatar(
                                              radius: 11.5,
                                              backgroundColor:
                                                  colorConst.meroon,
                                              child: Icon(
                                                Icons.add,
                                                color: colorConst.white,
                                                size: scrWidth * 0.04,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: scrWidth * 0.02,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                    })
              ],
            ),
          ),
        ));
  }
}
