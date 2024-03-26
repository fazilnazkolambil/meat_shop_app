import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meat_shop_app/constant/color_const.dart';
import 'package:meat_shop_app/constant/image_const.dart';

import 'main.dart';

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
  int currentIndex=0;
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
        toolbarHeight: h * 0.08,
        leadingWidth: w*0.17,
        leading: CircleAvatar(
          radius: w*0.15,
          backgroundImage: AssetImage(imageConst.logo),
        ),
        title: Row(
          children: [
            SvgPicture.asset(iconConst.location),
            Text("Kuwait City, Kuwait",style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: w*0.04
            ),)
          ],
        ),
        actions: [
          SvgPicture.asset(iconConst.cart),
          SizedBox(width: w*0.03,),
          SvgPicture.asset(iconConst.notification),
          SizedBox(width: w*0.03,),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(w*0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: w*1,
                margin: EdgeInsets.only(bottom: w*0.05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(w*0.06)
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    fillColor: colorConst.grey1,
                    filled: true,
                    prefixIcon: SvgPicture.asset(iconConst.search,
                    ),prefixIconConstraints: BoxConstraints(
                    maxHeight: w*0.1,
                    maxWidth: w*0.1
                  ),
                    hintText: "Search here for anything you want...",
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: w * 0.04,
                        color: colorConst.grey),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 0.08),
                        borderSide: BorderSide(color: colorConst.grey1)
                      ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 0.08),
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
                      milliseconds: 100,
                    )
                ),
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return  Container(
                    height: w*0.5,
                    width: w*1,
                    margin: EdgeInsets.only(right: w*0.03),
                    decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(w*0.04) ,
                        color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage(images[index]),
                            fit: BoxFit.fill
                        )
                    ),
                  );
                },
              ),
              SizedBox(height: h*0.02,),
              Expanded(
                child: GridView.builder(
                  itemCount: 4,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: w * 0.04 ,
                    childAspectRatio:1 ,
                    crossAxisSpacing: w* 0.04,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      height: w*0.5,
                      width: w*0.5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(w*0.03),
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
                            radius: w*0.15,
                            backgroundColor: Colors.amber,
                            backgroundImage: AssetImage(picandtext[index]["pic"],),
                          ),
                          Text(picandtext[index]["text1"],
                            style: TextStyle(fontSize: w*0.04),),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}