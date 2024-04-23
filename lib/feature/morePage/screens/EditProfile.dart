import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/NavigationPage.dart';
import 'package:meat_shop_app/models/userModel.dart';

import '../../../main.dart';

class EditProfile extends StatefulWidget {
  final String id;
  final String image;
  final String username;
  final String email;
  final String phonenumber;
  const EditProfile(
      {super.key,
      required this.id,
      required this.image,
      required this.username,
      required this.email,
      required this.phonenumber});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final phoneValidation = RegExp(r"[0-9]{10}");
  TextEditingController emailController = TextEditingController();
  final emailValidation = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final formKey = GlobalKey<FormState>();
  var countryCode;
  File? file;
  bool loading = false;
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

  String newImage = '';
  uploadImage(File file) async {
    loading = true;
    setState(() {

    });
    var uploadTask = await FirebaseStorage.instance
        .ref("userImages")
        .child(DateTime.now().toString())
        .putFile(file, SettableMetadata(contentType: "image/jpeg"));
    var getImage = await uploadTask.ref.getDownloadURL();
    newImage = getImage;
    loading = false;
    setState(() {

    });
  }
  
  UserModel? usermodel;
  getUserModel() async {
    await FirebaseFirestore.instance.collection('users').doc(widget.id).get().then((value) {
      usermodel = UserModel.fromMap(value.data()!);
    });
      UserModel tempUserModel = usermodel!.copyWith(
          image : newImage,
          name : nameController.text,
          email : emailController.text,
          number : countryCode.toString()+phoneController.text
      );
      await FirebaseFirestore.instance.collection('users').doc(widget.id).update(tempUserModel.toMap()).then((value){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationPage(),));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile Updated!")));
      });

  }
  

  @override
  void initState() {
    nameController.text = widget.username;
    emailController.text = widget.email;
    if(widget.phonenumber.length == 13){
      phoneController.text=widget.phonenumber.substring(3,13);
      newImage = widget.image;
    }
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorConst.white,
        elevation: 0,
        toolbarHeight: scrHeight * 0.1,
        // leadingWidth: w * 0.03,
        title: Padding(
          padding: EdgeInsets.all(scrWidth * 0.03),
          child: Text("Edit Profile",
              style: TextStyle(
                  color: colorConst.black,
                  fontSize: scrWidth * 0.055,
                  fontWeight: FontWeight.w800)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(scrWidth * 0.05),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                loading?
                SizedBox(
                  height:scrHeight*0.15,
                    child: Lottie.asset(gifs.loadingGif)):
                Stack(
                  children: [
                    SizedBox(
                      height:scrHeight*0.15,
                      child: newImage.isEmpty
                          ? CircleAvatar(
                              radius: scrWidth*0.2,
                              backgroundImage: AssetImage(imageConst.logo),
                            )
                          : CircleAvatar(
                              backgroundImage: NetworkImage(newImage),
                              radius: scrWidth*0.2,
                            ),

                    ),
                    Positioned(
                        bottom: 0,
                        right: 15,
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
                                                    fontSize: scrWidth * 0.04),
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
                                                        color: colorConst.white,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            scrWidth * 0.04),
                                                        border: Border.all(
                                                            color:
                                                            colorConst.grey)),
                                                    child: Icon(
                                                      Icons.camera_alt_outlined,
                                                      color: colorConst.black,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: scrWidth * 0.05,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      pickFile(
                                                          ImageSource.gallery);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: scrWidth * 0.1,
                                                      width: scrWidth * 0.1,
                                                      decoration: BoxDecoration(
                                                          color: colorConst.white,
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
                                                        color: colorConst.black,
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
                                        topLeft:
                                        Radius.circular(scrWidth * 0.02))),
                                child: Icon(
                                  Icons.edit,
                                  color: colorConst.white,
                                  size: scrWidth * 0.03,
                                )) //SvgPicture.asset(iconConst.edit),
                        ))
                  ],
                ),
                SizedBox(
                  height: scrWidth * 0.05,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: colorConst.white,
                      borderRadius: BorderRadius.circular(scrWidth * 0.04),
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
                        fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
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
                            borderSide: BorderSide(color: colorConst.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(scrWidth * 0.03),
                            borderSide: BorderSide(
                                color: colorConst.black.withOpacity(0.1))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(scrWidth * 0.03),
                            borderSide: BorderSide(
                                color: colorConst.black.withOpacity(0.1)))),
                  ),
                ),
                SizedBox(
                  height: scrWidth * 0.04,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: colorConst.white,
                      borderRadius: BorderRadius.circular(scrWidth * 0.04),
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
                        fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
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
                            borderSide: BorderSide(color: colorConst.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(scrWidth * 0.03),
                            borderSide: BorderSide(
                                color: colorConst.black.withOpacity(0.1))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(scrWidth * 0.03),
                            borderSide: BorderSide(
                                color: colorConst.black.withOpacity(0.1)))),
                  ),
                ),
                SizedBox(
                  height: scrWidth * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: colorConst.white,
                      borderRadius: BorderRadius.circular(scrWidth * 0.04),
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
                        fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
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
                            borderSide: BorderSide(color: colorConst.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(scrWidth * 0.03),
                            borderSide: BorderSide(
                                color: colorConst.black.withOpacity(0.1))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(scrWidth * 0.03),
                            borderSide: BorderSide(
                                color: colorConst.black.withOpacity(0.1)))),
                  ),
                ),
                SizedBox(
                  height: scrHeight * 0.03,
                ),
                InkWell(
                  onTap: () {
                   if(
                   nameController.text != "" &&
                       emailController.text != "" &&
                       phoneController.text != "" &&
                       formKey.currentState!.validate()
                   ){
                     getUserModel();


                  }else{
                     nameController.text == "" ?
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your Name!")))
                         :emailController.text == "" ?
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your email!")))
                         :phoneController.text == "" ?
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your Phonenumber")))
                         :ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your valid details!")));
            
                         }
                   }
                   ,
                  child: Container(
                      height: scrWidth * 0.17,
                      width: scrWidth * 0.9,
                      decoration: BoxDecoration(
                        color: colorConst.meroon,
                        // color: colorConst.meroon,
                        borderRadius: BorderRadius.circular(scrWidth * 0.07),
                      ),
                      child: Center(
                          child: Text("Update",
                              style: TextStyle(
                                  color: colorConst.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: scrWidth * 0.04)))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
