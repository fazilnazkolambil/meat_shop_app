import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/homePage/repository/homePageProviders.dart';
import 'package:meat_shop_app/feature/homePage/screens/camel_list.dart';
import 'package:meat_shop_app/feature/homePage/screens/meatList.dart';
import 'package:meat_shop_app/feature/homePage/screens/lamb_page.dart';
import 'package:shimmer/shimmer.dart';

import '../../../main.dart';
import '../../ordersPage/screens/cart_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List images=[
    "assets/images/carosal1.png",
    "assets/images/carosal1.png",
    "assets/images/carosal1.png",
    "assets/images/carosal1.png",
  ];
bool loading  = false;

  @override
  Widget build(BuildContext context) {
    final select = ref.watch(carouselaProvider)??0;
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
          SizedBox(width: scrWidth*0.03,),
          SvgPicture.asset(iconConst.notification),
          SizedBox(width: scrWidth*0.03,),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(scrWidth*0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: scrHeight*0.067,
                width: scrWidth*1,
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
                      ref.read(carouselaProvider.notifier).update((state) => index);
                    },
                    autoPlayAnimationDuration: Duration(
                      seconds: 1,
                    )
                ),
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return  Container(
                    height: scrHeight*0.4,
                    width: scrWidth*1,
                    decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(scrWidth*0.04) ,
                        image: DecorationImage(
                            image: AssetImage(images[index]),
                            fit: BoxFit.fill
                        )
                    ),
                  );
                },
              ),
              SizedBox(height: scrHeight*0.03,),
              SizedBox(
                height: scrHeight*0.5,
                width: scrWidth*1,
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
                        mainAxisSpacing: scrWidth * 0.05 ,
                        childAspectRatio: 1,
                        crossAxisSpacing: scrWidth* 0.05,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MeatListPage(
                              type: data[index]["type"],
                            )));
                          },
                          child: Container(
                            height: scrWidth*0.5,
                            width: scrWidth*0.5,
                            decoration: BoxDecoration(
                                color: colorConst.white,
                                borderRadius: BorderRadius.circular(scrWidth*0.03),
                                border: Border.all(color: colorConst.grey1),
                                boxShadow: [
                                  BoxShadow(
                                    color: colorConst.black.withOpacity(0.1),
                                    blurRadius: 4,
                                  )
                                ]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                loading? Shimmer(
                                    child: CircleAvatar(
                                      radius: scrWidth*0.15,
                                    ),
                                    gradient: LinearGradient(
                                        colors: [
                                          colorConst.grey,
                                          colorConst.white
                                        ])
                                )
                                :CircleAvatar(
                                  radius: scrWidth*0.15,
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

    );
  }
}
