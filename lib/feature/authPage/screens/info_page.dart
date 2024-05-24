import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/authPage/screens/signin_page.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/NavigationPage.dart';
import 'package:meat_shop_app/feature/ordersPage/screens/checkoutpage.dart';
import 'package:meat_shop_app/models/orderDetailsModel.dart';
import 'package:meat_shop_app/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../controller/AuthController.dart';

class infoPage extends ConsumerStatefulWidget {
  final String path;
  const infoPage({Key? key,
     required this.path
  }) : super(key: key);

  @override
  ConsumerState<infoPage> createState() => _infoPageState();
}

class _infoPageState extends ConsumerState<infoPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var countryCode;

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool visibility = true;
  bool visibility1 = true;
  bool check = false;
  String? loginUserId;

  final emailValidation = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final passwordValidation =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final phoneValidation = RegExp(r"[0-9]{10}");
  // final confirmPasswordValidation=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final formkey = GlobalKey<FormState>();
  File? file;
  pickFile(ImageSource) async {
    final imageFile =
        await ImagePicker.platform.getImageFromSource(source: ImageSource);
    file = File(imageFile!.path);
    if (mounted) {
      setState(() {
        file = File(imageFile.path);
      });
    }
    uploadImage(file!);
  }

  String imageUrl = '';
  uploadImage(File file) async {
    var uploadTask = await FirebaseStorage.instance
        .ref("userImages")
        .child(DateTime.now().toString())
        .putFile(file, SettableMetadata(contentType: "image/jpeg"));
    var getImage = await uploadTask.ref.getDownloadURL();
    imageUrl = getImage;
  }

  addUser() async {
    ref.watch(authControllerProvider).adding(userModel: UserModel(
        name: nameController.text.trim(),
        email: emailController.text,
        password: passwordController.text,
        number: countryCode.toString() + phoneController.text,
        address: [],
        favourites: [],
        image: imageUrl,
        id: '',), context: context);
   // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool("LoggedIn", true);
    // prefs.setString("loginUserId", loginUserId!);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorConst.white,
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      SizedBox(
                        child: Column(
                          children: [
                            file != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(imageUrl),
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        AssetImage(imageConst.logo),
                                    radius: 50,
                                  ),
                          ],
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              pickFile(ImageSource.camera);
                                              Navigator.pop(context);
                                            },
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Choose a file form",
                                                  style: TextStyle(
                                                      fontSize:
                                                          scrWidth * 0.04),
                                                ),
                                                SizedBox(
                                                  height: scrWidth * 0.04,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: scrWidth * 0.1,
                                                      width: scrWidth * 0.1,
                                                      decoration: BoxDecoration(
                                                          color: colorConst
                                                              .white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      scrWidth *
                                                                          0.04),
                                                          border: Border.all(
                                                              color: colorConst
                                                                  .grey)),
                                                      child: Icon(
                                                        Icons
                                                            .camera_alt_outlined,
                                                        color: colorConst.black,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: scrWidth * 0.05,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        pickFile(ImageSource
                                                            .gallery);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        height: scrWidth * 0.1,
                                                        width: scrWidth * 0.1,
                                                        decoration: BoxDecoration(
                                                            color: colorConst
                                                                .white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        scrWidth *
                                                                            0.04),
                                                            border: Border.all(
                                                                color: colorConst
                                                                    .meroon)),
                                                        child: Icon(
                                                          Icons.image,
                                                          color:
                                                              colorConst.black,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                  height: scrWidth * 0.05,
                                  width: scrWidth * 0.05,
                                  decoration: BoxDecoration(
                                      color: colorConst.meroon,
                                      borderRadius: BorderRadius.only(
                                          bottomRight:
                                              Radius.circular(scrWidth * 0.02),
                                          topLeft: Radius.circular(
                                              scrWidth * 0.02))),
                                  child: Icon(
                                    Icons.edit,
                                    color: colorConst.white,
                                    size: scrWidth * 0.03,
                                  )) //SvgPicture.asset(iconConst.edit),
                              ))
                    ],
                  ),
                ),
              ],
            ),
            Form(
                key: formkey,
                child: Padding(
                  padding: EdgeInsets.all(scrWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: scrWidth * 0.03,
                      ),
                      Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: scrWidth * 0.045,
                            fontWeight: FontWeight.w700,
                            color: colorConst.meroon),
                      ),
                      SizedBox(
                        height: scrWidth * 0.03,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: colorConst.white,
                            borderRadius:
                                BorderRadius.circular(scrWidth * 0.04),
                            border: Border.all(
                                width: scrWidth * 0.0003,
                                color: colorConst.black.withOpacity(0.38)),
                            boxShadow: [
                              BoxShadow(
                                  color: colorConst.black.withOpacity(0.1),
                                  blurRadius: 14,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0)
                            ]),
                        child: TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                              fontSize: scrWidth * 0.04,
                              fontWeight: FontWeight.w600),
                          cursorColor: colorConst.grey,
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(scrWidth * 0.04),
                                child: Container(
                                  height: scrWidth * 0.07,
                                  width: scrWidth * 0.07,
                                  child: SvgPicture.asset(
                                    iconConst.profile,
                                    color: colorConst.grey,
                                  ),
                                ),
                              ),
                              labelText: "Enter your full name",
                              labelStyle: TextStyle(
                                  fontSize: scrWidth * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: colorConst.grey),
                              filled: true,
                              fillColor: colorConst.white,
                              hintText: "Enter your full name",
                              hintStyle: TextStyle(
                                  fontSize: scrWidth * 0.04,
                                  fontWeight: FontWeight.w700,
                                  color: colorConst.grey),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: colorConst.red)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(scrWidth * 0.03),
                                  borderSide: BorderSide(
                                      color:
                                          colorConst.black.withOpacity(0.1))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(scrWidth * 0.03),
                                  borderSide: BorderSide(
                                      color:
                                          colorConst.black.withOpacity(0.1)))),
                        ),
                      ),
                      SizedBox(
                        height: scrWidth * 0.04,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: colorConst.white,
                            borderRadius:
                                BorderRadius.circular(scrWidth * 0.04),
                            border: Border.all(
                                width: scrWidth * 0.0003,
                                color: colorConst.black.withOpacity(0.38)),
                            boxShadow: [
                              BoxShadow(
                                  color: colorConst.black.withOpacity(0.1),
                                  blurRadius: 14,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0)
                            ]),
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                              fontSize: scrWidth * 0.04,
                              fontWeight: FontWeight.w600),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (!phoneValidation.hasMatch(value!)) {
                              return "enter valid phone number";
                            } else {
                              return null;
                            }
                          },
                          cursorColor: colorConst.grey,
                          decoration: InputDecoration(
                              counterText: "",
                              prefixIcon: CountryCodePicker(
                                onChanged: (value) {
                                  countryCode = value;
                                  setState(() {});
                                },
                                onInit: (value) {
                                  countryCode = value;
                                },
                                initialSelection: "+91",
                                showFlag: true,
                              ),
                              labelText: "Enter Your Phone Number",
                              labelStyle: TextStyle(
                                  fontSize: scrWidth * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: colorConst.grey),
                              filled: true,
                              fillColor: colorConst.white,
                              hintText: "Enter your Phone Number",
                              hintStyle: TextStyle(
                                  fontSize: scrWidth * 0.04,
                                  fontWeight: FontWeight.w700,
                                  color: colorConst.grey),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: colorConst.red)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(scrWidth * 0.03),
                                  borderSide: BorderSide(
                                      color:
                                          colorConst.black.withOpacity(0.1))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(scrWidth * 0.03),
                                  borderSide: BorderSide(
                                      color:
                                          colorConst.black.withOpacity(0.1)))),
                        ),
                      ),
                      SizedBox(
                        height: scrWidth * 0.03,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: colorConst.white,
                            borderRadius:
                                BorderRadius.circular(scrWidth * 0.04),
                            border: Border.all(
                                width: scrWidth * 0.0003,
                                color: colorConst.black.withOpacity(0.38)),
                            boxShadow: [
                              BoxShadow(
                                  color: colorConst.black.withOpacity(0.1),
                                  blurRadius: 14,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0)
                            ]),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                              fontSize: scrWidth * 0.04,
                              fontWeight: FontWeight.w600),
                          cursorColor: colorConst.grey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (!emailValidation.hasMatch(value!)) {
                              return "enter valid email";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(scrWidth * 0.04),
                                child: Container(
                                  child: SvgPicture.asset(
                                    iconConst.email,
                                  ),
                                ),
                              ),
                              labelText: "Enter Your Email",
                              labelStyle: TextStyle(
                                  fontSize: scrWidth * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: colorConst.grey),
                              filled: true,
                              fillColor: colorConst.white,
                              hintText: "Enter your Email Address",
                              hintStyle: TextStyle(
                                  fontSize: scrWidth * 0.04,
                                  fontWeight: FontWeight.w700,
                                  color: colorConst.grey),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: colorConst.red)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(scrWidth * 0.03),
                                  borderSide: BorderSide(
                                      color:
                                          colorConst.black.withOpacity(0.1))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(scrWidth * 0.03),
                                  borderSide: BorderSide(
                                      color:
                                          colorConst.black.withOpacity(0.1)))),
                        ),
                      ),
                      SizedBox(
                        height: scrWidth * 0.04,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: colorConst.white,
                            borderRadius:
                                BorderRadius.circular(scrWidth * 0.04),
                            border: Border.all(
                                width: scrWidth * 0.0003,
                                color: colorConst.black.withOpacity(0.38)),
                            boxShadow: [
                              BoxShadow(
                                  color: colorConst.black.withOpacity(0.1),
                                  blurRadius: 14,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0)
                            ]),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {});
                          },
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          obscureText: visibility ? true : false,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: scrWidth * 0.04),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (!passwordValidation.hasMatch(value!)) {
                              return "Password must contain at least 8 characters with \n one number,one lowercae(a-z),one uppercase(A-Z) \n , one special character";
                            } else {
                              return null;
                            }
                          },
                          cursorColor: colorConst.grey,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: colorConst.white,
                              suffixIcon: InkWell(
                                onTap: () {
                                  visibility = !visibility;
                                  setState(() {});
                                },
                                child: Icon(
                                  visibility == true
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: colorConst.grey,
                                ),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(scrWidth * 0.038),
                                child: Container(
                                    child:
                                        SvgPicture.asset(iconConst.password)),
                              ),
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  fontSize: scrWidth * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: colorConst.grey),
                              hintText: "Please Enter your Password",
                              hintStyle: TextStyle(
                                  fontSize: scrWidth * 0.04,
                                  fontWeight: FontWeight.w700,
                                  color: colorConst.grey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: colorConst.red,
                                ),
                                borderRadius:
                                    BorderRadius.circular(scrWidth * 0.03),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(scrWidth * 0.03),
                                  borderSide: BorderSide(
                                      color:
                                          colorConst.black.withOpacity(0.1))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(scrWidth * 0.03),
                                  borderSide: BorderSide(
                                      color:
                                          colorConst.black.withOpacity(0.1)))),
                        ),
                      ),
                      SizedBox(
                        height: scrWidth * 0.04,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: colorConst.white,
                            borderRadius:
                                BorderRadius.circular(scrWidth * 0.04),
                            border: Border.all(
                                width: scrWidth * 0.0003,
                                color: colorConst.black.withOpacity(0.38)),
                            boxShadow: [
                              BoxShadow(
                                  color: colorConst.black.withOpacity(0.1),
                                  blurRadius: 14,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0)
                            ]),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {});
                          },
                          controller: confirmPasswordController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          obscureText: visibility1 ? true : false,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: scrWidth * 0.04),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (confirmPasswordController.text !=
                                passwordController.text) {
                              return "Password does not match";
                            } else {
                              return null;
                            }
                          },
                          cursorColor: colorConst.grey,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: colorConst.white,
                              suffixIcon: InkWell(
                                onTap: () {
                                  visibility1 = !visibility1;
                                  setState(() {});
                                },
                                child: Icon(
                                  visibility1 == true
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: colorConst.grey,
                                ),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(scrWidth * 0.038),
                                child: Container(
                                    child:
                                        SvgPicture.asset(iconConst.password)),
                              ),
                              labelText: "confirm Password",
                              labelStyle: TextStyle(
                                  fontSize: scrWidth * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: colorConst.grey),
                              hintText: "Please re-enter your  Password",
                              hintStyle: TextStyle(
                                  fontSize: scrWidth * 0.04,
                                  fontWeight: FontWeight.w700,
                                  color: colorConst.grey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: colorConst.red),
                                borderRadius:
                                    BorderRadius.circular(scrWidth * 0.03),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(scrWidth * 0.03),
                                  borderSide: BorderSide(
                                      color:
                                          colorConst.black.withOpacity(0.1))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(scrWidth * 0.03),
                                  borderSide: BorderSide(
                                      color:
                                          colorConst.black.withOpacity(0.1)))),
                        ),
                      ),
                      SizedBox(height: scrWidth * 0.06),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: scrWidth * 0.05,
                                width: scrWidth * 0.05,
                                decoration: BoxDecoration(
                                    color: colorConst.white,
                                    borderRadius: BorderRadius.circular(
                                        scrWidth * 0.01),
                                    border: Border.all(
                                        width: scrWidth * 0.0003,
                                        color: colorConst.black
                                            .withOpacity(0.38)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: colorConst.black
                                              .withOpacity(0.1),
                                          blurRadius: 14,
                                          offset: Offset(0, 4),
                                          spreadRadius: 0)
                                    ]),
                                child: Checkbox(
                                  value: check,
                                  activeColor: colorConst.meroon,
                                  side: BorderSide(
                                      color:
                                          colorConst.black.withOpacity(0.1)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.01)),
                                  onChanged: (value) {
                                    setState(() {
                                      check = value!;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: scrWidth * 0.04,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "* By login I Agree with all the",
                                    style: TextStyle(
                                        fontSize: scrWidth * 0.034,
                                        fontWeight: FontWeight.w500,
                                        color: colorConst.grey),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => (),));
                                    },
                                    child: Text(
                                      " Terms & Conditions",
                                      style: TextStyle(
                                          fontSize: scrWidth * 0.034,
                                          fontWeight: FontWeight.w700,
                                          color: colorConst.meroon),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: scrWidth * 0.03,
                      ),
                      InkWell(
                          onTap: () {
                            if (
                                check == true &&
                                passwordController.text == confirmPasswordController.text &&
                                nameController.text != "" &&
                                phoneController.text != "" &&
                                emailController.text != "" &&
                                passwordController.text != "" &&
                                confirmPasswordController.text != "" &&
                                formkey.currentState!.validate()) {
                              // FirebaseAuth.instance.createUserWithEmailAndPassword(
                              //         email: emailController.text,
                              //         password: passwordController.text)
                              //     .then((value) async {
                                 addUser();
                                if (widget.path == "cartPage") {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => checkoutpage(
                                    price: 0,
                                    discount: 0,
                                    shippingCharge: 0,
                                    subtotal: 0,
                                    cartMeat: [],

                                  )));
                                } else {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationPage()));
                                }

                              //   FirebaseFirestore.instance.collection('users')
                              //       .add(
                              //       UserModel(
                              //         name: nameController.text,
                              //         email: emailController.text,
                              //         password: passwordController.text,
                              //         number: countryCode.toString() +
                              //             phoneController.text,
                              //         address: [],
                              //         favourites: [],
                              //         image: imageUrl,
                              //         id: '',
                              //       ).toMap())
                              //       .then((value) {
                              //     loginUserId = value.id;
                              //     value.update({
                              //       "id": value.id
                              //     }).then((value) async {
                              //       SharedPreferences prefs = await SharedPreferences.getInstance();
                              //       prefs.setBool("LoggedIn", true);
                              //       prefs.setString("loginUserId",loginUserId!);
                              //     }).then((value) {
                              //       if(widget.path == "MeatPage"){
                              //         Navigator.pushReplacement(context,
                              //         MaterialPageRoute(builder: (context) => checkoutpage(),));
                              //       }else{
                              //         Navigator.pushReplacement(context,
                              //         MaterialPageRoute(builder: (context) => NavigationPage(),));
                              //       }
                              //     });
                              //   });
                              // }).catchError((onError) {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       SnackBar(content: Text(onError.code)));
                              // });
                            } else {
                              nameController.text == ""
                                  ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text("Please enter your name!")))
                                  : phoneController.text == ""
                                      ? ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Please enter your phone number!")))
                                      : emailController.text == ""
                                          ? ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Please enter your email!")))
                                          : passwordController.text == ""
                                              ? ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Please enter a password!")))
                                              : confirmPasswordController.text ==
                                                      ""
                                                  ? ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(content: Text("Please re-enter your password!")))
                                                  : check == false
                                                      ? ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Please agree to the Terms and Conditions!")))
                                                      : ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Please enter your valid details!")));
                            }
                          },
                          child: Container(
                              height: scrWidth * 0.17,
                              width: scrWidth * 0.9,
                              decoration: BoxDecoration(
                                color: check == true
                                    ? colorConst.meroon
                                    : colorConst.grey,
                                // color: colorConst.meroon,
                                borderRadius:
                                    BorderRadius.circular(scrWidth * 0.07),
                              ),
                              child: Center(
                                  child: Text("Sign up",
                                      style: TextStyle(
                                          color: colorConst.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: scrWidth * 0.04))))),
                      SizedBox(
                        height: scrWidth * 0.15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have account",
                            style: TextStyle(
                                fontSize: scrWidth * 0.04,
                                fontWeight: FontWeight.w500,
                                color: colorConst.grey),
                          ),
                          SizedBox(
                            width: scrWidth * 0.02,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => signinPage(
                                      path: '',
                                    ),
                                  ));
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: scrWidth * 0.047,
                                  fontWeight: FontWeight.w800,
                                  color: colorConst.meroon),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
