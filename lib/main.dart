import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meat_shop_app/feature/favoritePage/screens/favourite_page.dart';
import 'package:meat_shop_app/feature/homePage/screens/HomePage.dart';
import 'package:meat_shop_app/feature/homePage/screens/beef_list.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/NavigationPage.dart';
import 'package:meat_shop_app/feature/ordersPage/screens/cart_page.dart';

import 'feature/onboardPage/screens/splashScreen.dart';
import 'firebase_options.dart';
var scrWidth;
var scrHeight;

 main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    scrWidth=MediaQuery.of(context).size.width;
    scrHeight=MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: ThemeData(
          textTheme:GoogleFonts.manropeTextTheme()
      ),
      debugShowCheckedModeBanner: false,
      home: NavigationPage(),
    );
  }
}

