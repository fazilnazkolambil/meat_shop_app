import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
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
import '../../../models/addressModel.dart';

class editaddress extends StatefulWidget {
  final String id;
  final String name;
  final String address;
  final String pincode;
  final String houseno;
  final String landmark;
  final String phonenumber;
  const editaddress(
      {super.key,
        required this.id,
        required this.address,
        required this.pincode,
        required this.houseno,
        required this.phonenumber,
        required this.name,
        required this.landmark});

  @override
  State<editaddress> createState() => _editaddressState();
}

class _editaddressState extends State<editaddress> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController housenoController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final emailValidation = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final formKey = GlobalKey<FormState>();
  var countryCode;
  File? file;
  bool loading = false;
  String newImage = '';
  List addre=[];
  UserModel? userModel;
  editAddress()async{
    addressModel address=addressModel(
      name: nameController.text,
      number:phoneController.text,
      landmark: landmarkController.text,
      houseno: housenoController.text,
      pincode: pincodeController.text,
      address: addressController.text,
    );

    await FirebaseFirestore.instance.collection("users").doc(loginId).get().then((value) {
      userModel = UserModel.fromMap(value.data()!);
    });
    addre=userModel!.address;
    addre.add(address.toMap());
    UserModel tempuserModel=userModel!.copyWith(
        address: addre
    );
    await FirebaseFirestore.instance.collection("users").doc(loginId).update(tempuserModel.toMap());
  }
  @override
  void initState() {
    nameController.text = widget.name;
    addressController.text = widget.address;
    pincodeController.text = widget.pincode;
    housenoController.text = widget.houseno;
    phoneController.text = widget.phonenumber;
    landmarkController.text = widget.landmark;
    if(widget.phonenumber.length == 13){
      phoneController.text=widget.phonenumber.substring(3,13);
      newImage = widget.address;
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
          child: Text("Edit Address",
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
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                    cursorColor: colorConst.grey,
                    decoration: InputDecoration(
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
                    controller: addressController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                    cursorColor: colorConst.grey,
                    decoration: InputDecoration(
                        labelText: "Enter your address",
                        labelStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            fontWeight: FontWeight.w600,
                            color: colorConst.grey),
                        filled: true,
                        fillColor: colorConst.white,
                        hintText: "Enter your address",
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
                    controller: pincodeController,
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                    cursorColor: colorConst.grey,
                    decoration: InputDecoration(

                        labelText: "Enter your pincode",
                        labelStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            fontWeight: FontWeight.w600,
                            color: colorConst.grey),
                        filled: true,
                        fillColor: colorConst.white,
                        hintText: "Enter your pincode",
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
                    controller: housenoController,
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                    cursorColor: colorConst.grey,
                    decoration: InputDecoration(
                        labelText: "Enter your house no",
                        labelStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            fontWeight: FontWeight.w600,
                            color: colorConst.grey),
                        filled: true,
                        fillColor: colorConst.white,
                        hintText: "Enter your house no",
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
                    controller: landmarkController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                    cursorColor: colorConst.grey,
                    decoration: InputDecoration(
                        labelText: "Enter your landmark",
                        labelStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            fontWeight: FontWeight.w600,
                            color: colorConst.grey),
                        filled: true,
                        fillColor: colorConst.white,
                        hintText: "Enter your landmark",
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
                    // validator: (value) {
                    //   if (!phoneValidation.hasMatch(value!)) {
                    //     return "enter valid phone number";
                    //   } else {
                    //     return null;
                    //   }
                    // },
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
                  height: scrHeight * 0.03,
                ),
                InkWell(
                  onTap: () {
                    if(
                    nameController.text != "" &&
                        phoneController.text != "" &&
                        housenoController.text != "" &&
                        pincodeController.text != "" &&
                        landmarkController.text != "" &&
                        addressController.text != ""
                    ){
                      editAddress();
                      Navigator.pop(context);

                    }else{
                      nameController.text == "" ?
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your Name!")))
                          :phoneController.text == "" ?
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your Phonenumber")))
                          :housenoController.text == "" ?
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your house no")))
                          :pincodeController.text == "" ?
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your pincode")))
                          :addressController.text == "" ?
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your address")))
                          :landmarkController.text == "" ?
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your landmark")))
                          :ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your valid details!")));

                    }
                    setState(() {

                    });
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
