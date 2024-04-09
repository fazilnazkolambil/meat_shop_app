import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meat_shop_app/feature/authPage/screens/info_page.dart';
import 'package:meat_shop_app/feature/authPage/screens/signin_page.dart';
import 'package:meat_shop_app/feature/favoritePage/screens/favourite_page.dart';
import 'package:meat_shop_app/feature/forgotpassword/createnewpswrd.dart';
import 'package:meat_shop_app/feature/forgotpassword/forgotpassword1.dart';
import 'package:meat_shop_app/feature/homePage/screens/HomePage.dart';
import 'package:meat_shop_app/feature/homePage/screens/Mutton_List.dart';
import 'package:meat_shop_app/feature/homePage/screens/meatList.dart';
import 'package:meat_shop_app/feature/homePage/screens/camel_list.dart';
import 'package:meat_shop_app/feature/homePage/screens/lamb_page.dart';
import 'package:meat_shop_app/feature/morePage/screens/more_page.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/NavigationPage.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/onBoardingPage.dart';
import 'package:meat_shop_app/feature/ordersPage/screens/My_Orders.dart';
import 'package:meat_shop_app/feature/ordersPage/screens/cart_page.dart';
import 'package:meat_shop_app/feature/ordersPage/screens/checkoutpage.dart';
import 'package:meat_shop_app/feature/ordersPage/screens/orderconfirm_page.dart';
import 'package:meat_shop_app/feature/ordersPage/screens/orderdetails_page.dart';

import 'feature/onboardPage/screens/splashScreen.dart';
import 'firebase_options.dart';
var scrWidth;
var scrHeight;

 main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    scrWidth=MediaQuery.of(context).size.width;
    scrHeight=MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: MaterialApp(
        theme: ThemeData(
            textTheme:GoogleFonts.manropeTextTheme()
        ),
        debugShowCheckedModeBanner: false,
        home:NavigationPage(),
      ),
    );
  }
}

