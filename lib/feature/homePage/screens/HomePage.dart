import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/homePage/screens/beef_list.dart';
import 'package:meat_shop_app/feature/homePage/screens/lamb_page.dart';

import '../../../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List images=[
    "assets/images/carosal1.png",
    "assets/images/carosal1.png",
    "assets/images/carosal1.png",
    "assets/images/carosal1.png",
  ];
  int currentIndex=-1;
  List picandtext=[
    {
      "pic":"assets/images/beef.png",
      "text1":"Beef",
    },
    {
      "pic":"assets/images/motton.png",
      "text1":"Mutton",
    },
    {
      "pic":"assets/images/lamb.png",
      "text1":"Lamb",
    },
    {
      "pic":"assets/images/camel.png",
      "text1":"Camel",
    },


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: scrHeight * 0.055,
        leadingWidth: scrWidth*0.7,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: scrWidth*0.05,
              backgroundImage: AssetImage(imageConst.logo),
            ),
             Row(
               children: [
                 SvgPicture.asset(iconConst.location),
                 Text("Kuwait City, Kuwait",style: TextStyle(
                     color: Colors.black87,
                     fontWeight: FontWeight.w600,
                     fontSize: scrWidth*0.04
                 ),),
               ],
             ),
          ],
        ),

        actions: [
          SvgPicture.asset(iconConst.cart),
          SizedBox(width: scrWidth*0.03,),
          SvgPicture.asset(iconConst.notification),
          SizedBox(width: scrWidth*0.03,),
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(scrWidth*0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: scrHeight*0.067,
                  width: scrWidth*1,
                  margin: EdgeInsets.only(bottom: scrWidth*0.03),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                      fontSize: scrWidth * 0.04,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      fillColor: colorConst.grey1,
                      filled: true,
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
                ),
                CarouselSlider.builder(
                  itemCount: images.length,
                  options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        currentIndex=index;
                        setState(() {

                        });
                      },
                      autoPlayAnimationDuration: Duration(
                        seconds: 1,
                      )
                  ),
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    return  Container(
                      height: scrHeight*0.4,
                      width: scrWidth*1,
                      margin: EdgeInsets.only(right: scrWidth*0.03),
                      decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(scrWidth*0.04) ,
                          color: Colors.black,
                          image: DecorationImage(
                              image: AssetImage(images[index]),
                              fit: BoxFit.fill
                          )
                      ),
                    );
                  },
                ),
                SizedBox(height: scrHeight*0.012,),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('meatTypes').snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return Lottie.asset(gifs.loadingGif);
                      }
                      var data = snapshot.data!.docs;
                      return  data.isEmpty?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              height: scrHeight*0.15,
                              child: Lottie.asset(gifs.comingSoon)),
                          Text("Meats will be available Soon!",style: TextStyle(
                              fontSize: scrWidth*0.05,
                              fontWeight: FontWeight.w700,
                              color: colorConst.meroon
                          ),)
                        ],
                      ):
                        GridView.builder(
                        itemCount: data.length,
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: scrWidth * 0.04 ,
                          childAspectRatio:1 ,
                          crossAxisSpacing: scrWidth* 0.04,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BeefList(
                                type: data[index]["type"],
                              ),));
                            },
                            child: Container(
                              height: scrWidth*0.45,
                              width: scrWidth*0.45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(scrWidth*0.03),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.15),
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                    )
                                  ]
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                    radius: scrWidth*0.15,
                                    backgroundColor: Colors.amber,
                                    backgroundImage: NetworkImage(data[index]["mainImage"],),
                                  ),
                                  Text(data[index]["type"],
                                    style: TextStyle(fontSize: scrWidth*0.04),),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  ),
                ),
              ],
            ),
        ),
      ),

    );
  }
}
