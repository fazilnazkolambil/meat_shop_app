import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/homePage/repository/homePageProviders.dart';
import 'package:meat_shop_app/feature/ordersPage/screens/checkoutpage.dart';

import '../../../main.dart';
import '../../authPage/screens/signin_page.dart';

class MeatListPage extends ConsumerStatefulWidget {
  final String type;
  const MeatListPage({
    super.key,
    required this.type,
  });

  @override
  ConsumerState<MeatListPage> createState() => _MeatListPageState();
}

class _MeatListPageState extends ConsumerState<MeatListPage> {
  int selectedIndex = 0;
  String selectedCategory = '';
  String? category;
  int count = 1;
  List add = [];

  List categoryCollection = [];
  List meatCollection = [];
  getMeats() async {
    var category = await FirebaseFirestore.instance
        .collection("meatTypes")
        .doc(widget.type)
        .collection(widget.type)
        .get();
    categoryCollection = category.docs;
    setState(() {});
  }

  @override
  void initState() {
    getMeats();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    final quantity = ref.watch(quantityProvider);
    return Scaffold(
      backgroundColor: colorConst.white,
      bottomNavigationBar: add.isEmpty? SizedBox()
      :SizedBox(
        height: scrHeight*0.12,
        child: Padding(
          padding:  EdgeInsets.all(scrWidth*0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
            ],
          ),
        ),
      ),
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
                  child: Center(child: SvgPicture.asset(iconConst.backarrow))),
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
                  height: add.isEmpty?scrHeight*0.7:scrHeight*0.6,
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
                      if(!snapshot.hasData)
                        return Lottie.asset(gifs.loadingGif);
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
                                        add.isEmpty?
                                        Row(
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
                                            Container(
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
                                          ],
                                        ):
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
                                      Container(
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
                                      FavoriteButton(
                                        valueChanged: (_) {},
                                        iconSize: 39,
                                        iconColor: colorConst.meroon,
                                      ),
                                      // SvgPicture.asset(iconConst.Favourite,color: favourite.contains(index)?colorConst.meroon:colorConst.grey,),
                                      InkWell(
                                        onTap: () {
                                          if(add.contains(index)){
                                            add.remove(index);
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Removed from Cart")));
                                          }else{
                                            add.add(index);
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Added to Cart")));
                                          }
                                          setState(() {

                                          });
                                        },
                                        child:add.contains(index)?
                                        Icon(Icons.done,color: colorConst.green)
                                        :CircleAvatar(
                                          radius: scrWidth*0.03,
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
