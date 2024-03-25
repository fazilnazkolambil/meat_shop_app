import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meat_shop_app/firebase_options.dart';
import 'package:meat_shop_app/more_page.dart';
import 'package:meat_shop_app/signin_page.dart';
var w;
var h;

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
    w=MediaQuery.of(context).size.width;
    h=MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: ThemeData(
          textTheme:GoogleFonts.manropeTextTheme()
      ),
      debugShowCheckedModeBanner: false,
      home: signinPage(),
    );
  }
}

