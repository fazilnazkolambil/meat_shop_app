import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:connectivity/connectivity.dart';

import '../../../main.dart';
import '../../../models/userModel.dart';
import '../controller/onBoardPageController.dart';
import 'NavigationPage.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  bool loaded = false;
  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();

  ConnectivityResult? _connectivityResult;
  checkConnectivity ()  {
    Connectivity().checkConnectivity().then((result) {
      setState(() {
        _connectivityResult = result;
      });
    });
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _connectivityResult = result;
      });
    });
  }
  logIn () async {
    if(_userName.text.isNotEmpty && _password.text.isNotEmpty){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter valid Details!")));
    }
  }
  bool end = false;

  int selectedIndex = 0;

  @override
  void initState() {
    getBannerCollections();
    super.initState();
    checkConnectivity ();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller!);
    Timer(Duration(seconds: 3), () async {
      if(_connectivityResult == ConnectivityResult.none){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              children: [
                Icon(Icons.wifi_off,color: colorConst.red,),
                SizedBox(width: 10,),
                Text("No internet connection!"),
              ],
            )
        ));
      }else{
        gotIn?Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationPage())):
        _controller!.forward();
        loaded = true;
      }

    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:colorConst.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller!,
          builder: (context, child) {
            return Stack(
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
                loaded?SizedBox():
                Positioned(
                    bottom: scrWidth*0.2,
                    left: scrWidth*0.25,
                    right: scrWidth*0.25,
                    child: SizedBox(
                        height: scrWidth*0.5,
                        width: scrWidth*0.5,
                        child: Lottie.asset(gifs.loadingGif))
                ),
                Transform.translate(
                  offset: Offset(0 , -scrWidth*0.5 * _animation!.value),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image(image: AssetImage(imageConst.mainIcon),height: scrWidth*0.5),
                      SizedBox(height: 20,),
                      Text("Meat Shop",style: TextStyle(
                          color: colorConst.white,
                          fontSize: scrWidth*0.08,
                          fontWeight: FontWeight.w600
                      )),
                      SizedBox(
                        height: scrWidth*0.1,
                      ),
                      Opacity (
                        opacity: _animation!.value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CarouselSlider.builder(
                              itemCount: introTexts.length,
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
                                        Text(introTexts[index]["title"],style: TextStyle(
                                            fontSize: scrWidth*0.05,
                                            fontWeight: FontWeight.w600,
                                            color: colorConst.white,
                                            letterSpacing: scrWidth*0.004
                                        ),),
                                        Text(introTexts[index]['subTitle'],style: TextStyle(
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
                                  enableInfiniteScroll: false,
                                autoPlay: selectedIndex == 2?false:true,
                                autoPlayAnimationDuration: Duration(seconds:2)
                              ),
                            ),
                            selectedIndex == introTexts.length-1?
                            InkWell(
                              onTap: () async{
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationPage(),));
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setBool("gotIn", true);
                              },
                              child: Container(
                                height: scrWidth*0.1,
                                width: scrWidth*0.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(scrWidth*0.03),
                                    color: colorConst.meroon
                                ),
                                child: Center(child: Text("Let's  In",style: TextStyle(
                                    color: colorConst.white,
                                  fontWeight: FontWeight.w600
                                ),)),
                              ),
                            )
                                :SizedBox(
                                    height: scrWidth*0.1,
                                     width: scrWidth*0.5,
                                  child: Center(
                                    child: AnimatedSmoothIndicator(
                                      activeIndex: selectedIndex,
                                      count: introTexts.length,
                                      effect: ExpandingDotsEffect(
                                    dotColor: colorConst.white.withOpacity(0.2),
                                    activeDotColor: colorConst.white.withOpacity(0.6),
                                    dotHeight: scrWidth * 0.01,
                                    dotWidth: scrWidth * 0.03,
                                                                  ),
                                                                ),
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),


              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}