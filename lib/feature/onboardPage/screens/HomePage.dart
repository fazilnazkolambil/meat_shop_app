import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/homePage/repository/homePageProviders.dart';
import 'package:meat_shop_app/feature/homePage/screens/meatList.dart';
import 'package:meat_shop_app/feature/homePage/screens/searchPage.dart';
import 'package:meat_shop_app/feature/onboardPage/controller/onBoardPageController.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/NavigationPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../main.dart';
import '../../../models/userModel.dart';
import '../../ordersPage/screens/cart_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String? userImage;
  List meatDetailCollection = [];
  bool loading = false;
  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginId = prefs.getString("loginUserId") ?? "";
    String? jsonString = prefs.getString("cart");
    String? jsonString2 = prefs.getString("cart2");
    if (jsonString != null && jsonString2 != null) {
      setState(() {
        meatDetailCollection = json.decode(jsonString);
        addCart = json.decode(jsonString2);
      });
    }
    if (loginId.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(loginId)
          .get()
          .then((value) {
        UserModel users = UserModel.fromMap(value.data()!);
        userImage = users.image;
      });
    }
    setState(() {});
  }

  getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Future.error('Location permissions are denied');
      LocationPermission ask = await Geolocator.requestPermission();
    }
  }

  String? address;
  getAddress() async {
    try {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      // print(currentPosition.latitude);
      // print(currentPosition.longitude);
      List<Placemark> result = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark first = result.first;
      setState(() {
        address = "${first.locality}, ${first.administrativeArea}";
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to load your Location"),
            duration: Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
          ));
    }
  }

  @override
  void initState() {
    loadData();
    getLocation();
    getAddress();
    getBannerCollections();
    getMeatCollection();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(carouselaProvider) ?? 0;
    return Scaffold(
      backgroundColor: colorConst.white,
      appBar: AppBar(
        backgroundColor: colorConst.white,
        surfaceTintColor: colorConst.white,
        elevation: 0,
        leading: userImage != null && userImage != ""
            ? Padding(
                padding: EdgeInsets.all(scrWidth * 0.02),
                child: CircleAvatar(
                  radius: scrWidth * 0.05,
                  backgroundImage: NetworkImage(userImage!),
                ),
              )
            : Padding(
                padding: EdgeInsets.all(scrWidth * 0.02),
                child: CircleAvatar(
                  radius: scrWidth * 0.05,
                  backgroundImage: AssetImage(imageConst.logo),
                ),
              ),
        title: Row(
          children: [
            SvgPicture.asset(iconConst.location),
            SizedBox(
              width: scrWidth * 0.02,
            ),
            GestureDetector(
              onTap: () {
                getAddress();
              },
              child: Text(
                address == null ? "Fetching your location..." : "$address",
                style: TextStyle(
                    fontSize: scrWidth * 0.04, color: colorConst.black),
              ),
            )
          ],
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => cartPage(),
                    ));
              },
              child: meatDetailCollection.isEmpty
                  ? SvgPicture.asset(iconConst.cart)
                  : SizedBox(
                      height: scrWidth * 0.08,
                      width: scrWidth * 0.08,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: scrWidth * 0.03,
                            left: scrWidth * 0.03,
                            child: CircleAvatar(
                              backgroundColor: colorConst.meroon,
                              radius: scrWidth * 0.025,
                              child: Center(
                                child: Text(
                                  meatDetailCollection.length.toString(),
                                  style: TextStyle(
                                      color: colorConst.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: scrWidth * 0.03),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              left: 0,
                              bottom: 0,
                              child: SvgPicture.asset(
                                iconConst.cart,
                              )),
                        ],
                      ),
                    )),
          SizedBox(
            width: scrWidth * 0.03,
          ),
          SvgPicture.asset(iconConst.notification),
          SizedBox(
            width: scrWidth * 0.03,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await getAddress();
          await getBannerCollections();
          await getMeatCollection();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding:EdgeInsets.all(scrWidth*0.01),
            child: SizedBox(
              height: scrHeight*1,
              width: scrWidth*1,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchPage(),
                          ));
                    },
                    child: Container(
                      height: scrHeight * 0.07,
                      width: scrWidth * 1,
                      padding: EdgeInsets.all(scrWidth * 0.03),
                      margin: EdgeInsets.only(bottom: scrHeight * 0.02),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(scrWidth * 0.1),
                          color: colorConst.grey1),
                      child: Row(
                        children: [
                          SvgPicture.asset(iconConst.search),
                          SizedBox(
                            width: scrWidth * 0.02,
                          ),
                          Text(
                            "Search here for anything you want...",
                            style: TextStyle(color: colorConst.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: scrHeight*0.25,
                    width: scrWidth * 1,
                    child: Stack(
                      children: [
                        Center(
                          child: CarouselSlider.builder(
                            itemCount: introImages.length,
                            options: CarouselOptions(
                                enlargeCenterPage: true,
                                autoPlay: true,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                 ref.read(carouselaProvider.notifier).update((state) => index);
                                },
                                autoPlayAnimationDuration: Duration(seconds: 1)),
                            itemBuilder: (BuildContext context, int index,
                                int realIndex) {
                              return Container(
                                height: scrHeight * 0.4,
                                width: scrWidth * 1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        scrWidth * 0.04),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            introImages[index]),
                                        fit: BoxFit.fill)),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          child: SizedBox(
                            width: scrWidth * 1,
                            child: Center(
                              child: AnimatedSmoothIndicator(
                                activeIndex: selectedIndex,
                                count: introImages.length,
                                effect: ExpandingDotsEffect(
                                  dotColor:
                                      colorConst.white.withOpacity(0.5),
                                  activeDotColor: colorConst.white,
                                  dotHeight: scrWidth * 0.01,
                                  dotWidth: scrWidth * 0.03,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  meatTypes.isEmpty ?
                  SizedBox(
                    height: scrHeight*0.4,
                    width: scrWidth*1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            height: scrHeight * 0.15,
                            child: Lottie.asset(gifs.comingSoon)),
                        Text("Meats will be available Soon!",
                          style: TextStyle(
                              fontSize: scrWidth * 0.05,
                              fontWeight: FontWeight.w700,
                              color: colorConst.meroon),
                        )
                      ],
                    ),
                  ):
                  SizedBox(
                    height: scrHeight*0.4,
                    child: GridView.builder(
                    itemCount: meatTypesLength,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: scrWidth * 0.05,
                      childAspectRatio: 1,
                      crossAxisSpacing: scrWidth * 0.05,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MeatListPage(type: meatTypes[index]["name"],)));
                        },
                        child: Container(
                          height: scrWidth * 0.5,
                          width: scrWidth * 0.5,
                          decoration: BoxDecoration(
                              color: colorConst.white,
                              borderRadius: BorderRadius.circular(scrWidth * 0.03),
                              border: Border.all(color: colorConst.grey1),
                              boxShadow: [
                                BoxShadow(
                                  color: colorConst.black.withOpacity(0.1),
                                  blurRadius: 4,
                                )
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: scrWidth * 0.15,
                                backgroundImage: NetworkImage(meatTypes[index]["image"]),
                              ),
                              Text(
                                meatTypes[index]["name"], style: TextStyle(
                                  fontSize: scrWidth * 0.04),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                                ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
