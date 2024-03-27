import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../main.dart';

class onBoardingPage extends StatefulWidget {
  const onBoardingPage({super.key});

  @override
  State<onBoardingPage> createState() => _onBoardingPageState();
}

class _onBoardingPageState extends State<onBoardingPage> {
  List welcome = [
    {
      "title" : "Meat Shop \nshopping \ndelivered to your \nhome",
      "subtitle" : "There's something for everyone \nto enjoy with Sweet Shop \nFavorites"
    },
    {
      "title" : "FRESH \nand Hygienic Quality",
      "subtitle" : "You will get FRESH Meat and not frozen.\nSo you can assured that your money \nhas bought the best - in freshness, taste, safety!",
    },
    {
      "title" : "Prices are \nlower than in \nMarket",
      "subtitle" : "We provide fresh quality \nmeat in lower than Marker Price"
    }
  ];
  int selectedIndex = 0;
  bool end = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: scrHeight*1,
              width: scrWidth*1,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageConst.meetsplash),fit: BoxFit.fill,)
              )
          ),
          Container(
            height: scrHeight*1,
            width: scrWidth*1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: AlignmentDirectional(0, 1.5),
                  colors: [
                    colorConst.black,
                    colorConst.black.withOpacity(0.5),
                  ]),
            ),
          ),
          Positioned(
            top: scrWidth*0.35,
            child: SizedBox(
                 width: scrWidth*1,
                child:Column(
                  children: [
                    Image(image: AssetImage(imageConst.mainIcon),width: scrWidth*0.4),
                    Text("Meat Shop",style: TextStyle(
                        color: colorConst.white,
                        fontSize: scrWidth*0.07,
                        fontWeight: FontWeight.w600
                    ),)
                  ],
                )
            ),
          ),
          Positioned(
            top: scrWidth*1.2,
            right: 0,
            left: 0,
            child: CarouselSlider.builder(
              itemCount: welcome.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Container(
                  height: scrHeight*0.25,
                  width: scrWidth*1,
                  margin: EdgeInsets.all(scrWidth*0.05),
                  color: colorConst.black.withOpacity(0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(welcome[index]["title"],style: TextStyle(
                            fontSize: scrWidth*0.05,
                            fontWeight: FontWeight.w600,
                            color: colorConst.white,
                            letterSpacing: scrWidth*0.004
                        ),),
                        Text(welcome[index]['subtitle'],style: TextStyle(
                          color: colorConst.red,
                        ))
                      ],
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  selectedIndex = index;
                  setState(() {

                  });
                },
                viewportFraction: 1,
                enableInfiniteScroll: false
              ),
            )
          ),
          Positioned(
            top: scrWidth*1.8,
            right: scrWidth*0.4,
            left: scrWidth*0.4,
            child: selectedIndex == welcome.length-1?
            Container(
              height: scrWidth*0.1,
              width: scrWidth*0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(scrWidth*0.03),
                color: colorConst.meroon
              ),
              child: Center(child: Text("Let's  In",style: TextStyle(
                  color: colorConst.white),)),
            )
                :AnimatedSmoothIndicator(
                activeIndex: selectedIndex,
                count: welcome.length,
              effect: ExpandingDotsEffect(
                dotColor: colorConst.white.withOpacity(0.2),
                activeDotColor: colorConst.white.withOpacity(0.6),
                dotHeight: scrWidth * 0.01,
                dotWidth: scrWidth * 0.03,
              ),
            ),
          )
        ],
      ),
    );
  }
}
