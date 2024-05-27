import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/morePage/screens/myaddress.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/NavigationPage.dart';
import 'package:meat_shop_app/models/userModel.dart';

import '../../../main.dart';
import '../../../models/addressModel.dart';

class addnewaddress extends StatefulWidget {
  final String userName, userNumber;
  const addnewaddress(
      {super.key,required this.userName, required this.userNumber,});

  @override
  State<addnewaddress> createState() => _addnewaddressState();
}

class _addnewaddressState extends State<addnewaddress> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();

  String address = '';
  final emailValidation = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final phoneValidation = RegExp(r"[0-9]{10}");

  final formKey = GlobalKey<FormState>();
  bool validate = false;
  var countryCode;
  UserModel? userModel;
  List addre=[];
  String? userName;
  String userNumber= '';
  getUser(){
    FirebaseFirestore.instance.collection("users").doc(loginId).get().then((value) {
      userModel = UserModel.fromMap(value.data()!);
    });
    userName = userModel!.name;
    userNumber = userModel!.number;
  }
  addaddress()async{
    addressModel address=addressModel(
      name: nameController.text,
      number:numberController.text,
      landmark: '',
      houseno: houseController.text,
      pincode: pincodeController.text,
      address: '',
      deliveryinsruction: '',
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
  File? file;
  bool loading = false;
  String newImage = '';
  UserModel? usermodel;
  @override
  void initState() {
    //getUser();
    nameController.text = widget.userName;
    numberController.text = widget.userNumber.substring(3,13);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorConst.white,
        elevation: 0,
        toolbarHeight: scrHeight * 0.1,
        // leadingWidth: w * 0.03,
        title: Padding(
          padding: EdgeInsets.all(scrWidth * 0.03),
          child: InkWell(
            onTap: () {
              getUser();
            },
            child: Text("Add Address",
                style: TextStyle(
                    color: colorConst.black,
                    fontSize: scrWidth * 0.055,
                    fontWeight: FontWeight.w800)),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(scrWidth * 0.05),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom:scrWidth*0.03),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    readOnly: true,
                    style: TextStyle(
                        fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                    cursorColor: colorConst.grey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if(nameController.text.isEmpty){
                        return "Name is required";
                      }else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      constraints: BoxConstraints(maxHeight: 80),
                        labelText: "Full name *",
                        labelStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            color: colorConst.grey),
                        filled: true,
                        fillColor: colorConst.white,
                        hintText: "Enter your full name",
                        hintStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            fontWeight: FontWeight.w500,
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
                Padding(
                  padding:EdgeInsets.only(bottom: scrWidth*0.03),
                  child: TextFormField(
                    controller: numberController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    readOnly: true,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                        fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (!phoneValidation.hasMatch(value!)) {
                        return "Enter a valid Phone Number!";
                      } else {
                        return null;
                      }
                    },
                    cursorColor: colorConst.grey,
                    decoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 80),
                      prefix: Padding(
                        padding:EdgeInsets.only(right:scrWidth*0.03),
                        child: SizedBox(child: Text("+91"),),
                      ),
                        counterText: "",
                        prefixStyle: TextStyle(color: colorConst.black,fontWeight: FontWeight.w500),
                        labelText: "Phone Number *",
                        labelStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            color: colorConst.grey
                        ),
                        filled: true,
                        fillColor: colorConst.white,
                        hintText: "Enter your Phone Number",
                        hintStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            fontWeight: FontWeight.w500,
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
                Padding(
                  padding: EdgeInsets.only(bottom: scrWidth*0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        //height: scrHeight*0.06,
                        width: scrWidth*0.4,
                        child: TextFormField(
                          controller: pincodeController,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                              fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                          cursorColor: colorConst.grey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if(pincodeController.text.isEmpty){
                              return "Pincode is required";
                            }else{
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              constraints: BoxConstraints(maxHeight: 70),
                              counterText: "",
                              labelText: "Pincode *",
                              labelStyle: TextStyle(
                                  fontSize: scrWidth * 0.04,
                                  color: colorConst.grey
                              ),
                              filled: true,
                              fillColor: colorConst.white,
                              hintText: "Enter your Pincode",
                              hintStyle: TextStyle(
                                  fontSize: scrWidth * 0.04,
                                  fontWeight: FontWeight.w500,
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
                      InkWell(
                        onTap: () async {
                          LocationPermission permission = await Geolocator.checkPermission();
                          if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
                            Future.error('Location permissions are denied');
                            LocationPermission ask = await Geolocator.requestPermission();
                          }
                          try{
                            Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
                            // print(currentPosition.latitude);
                            // print(currentPosition.longitude);
                            List <Placemark> result = await placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);
                            Placemark first = result.first;
                            print(result);
                            setState(() {
                              pincodeController.text = first.postalCode!;
                              streetController.text = first.subLocality!;
                              townController.text = first.locality!;
                            });
                          }
                          catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to load your Location")));
                          }
                        },
                        child: Container(
                          height: scrHeight*0.06,
                          width: scrWidth*0.4,
                          decoration: BoxDecoration(
                            // color: colorConst.meroon.withOpacity(0.3),
                            border: Border.all(color: colorConst.meroon),
                            borderRadius: BorderRadius.circular(scrWidth*0.03),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                            Icon(Icons.my_location_outlined,color: colorConst.meroon,),
                            Text("My Location",style: TextStyle(color: colorConst.meroon),)
                          ],),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: scrWidth*0.03),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      //height: scrHeight*0.06,
                      width: scrWidth*0.4,
                      child: TextFormField(
                        controller: streetController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(
                            fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                        cursorColor: colorConst.grey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if(streetController.text.isEmpty){
                            return "Street is required";
                          }else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            constraints: BoxConstraints(maxHeight: 80),
                            labelText: "Street *",
                            labelStyle: TextStyle(
                                fontSize: scrWidth * 0.04,
                                color: colorConst.grey
                            ),
                            filled: true,
                            fillColor: colorConst.white,
                            hintText: "Enter your Street name",
                            hintStyle: TextStyle(
                                fontSize: scrWidth * 0.04,
                                fontWeight: FontWeight.w500,
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
                      //height: scrHeight*0.06,
                      width: scrWidth*0.4,
                      child: TextFormField(
                        controller: townController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(
                            fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                        cursorColor: colorConst.grey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if(townController.text.isEmpty){
                            return "City/Town is required";
                          }else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            constraints: BoxConstraints(maxHeight: 80),
                            labelText: "City/Town *",
                            labelStyle: TextStyle(
                                fontSize: scrWidth * 0.04,
                                color: colorConst.grey
                            ),
                            filled: true,
                            fillColor: colorConst.white,
                            hintText: "Enter your City/Town name",
                            hintStyle: TextStyle(
                                fontSize: scrWidth * 0.04,
                                fontWeight: FontWeight.w500,
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
                  ],
                )),
                SizedBox(
                  height: scrWidth * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom:scrWidth*0.03),
                  child: TextFormField(
                    controller: houseController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                    cursorColor: colorConst.grey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 80),
                        labelText: "House/Flat/Floor no.",
                        labelStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            color: colorConst.grey),
                        filled: true,
                        fillColor: colorConst.white,
                        // hintText: "Enter your full name",
                        // hintStyle: TextStyle(
                        //     fontSize: scrWidth * 0.04,
                        //     fontWeight: FontWeight.w500,
                        //     color: colorConst.grey),
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
                Padding(
                  padding: EdgeInsets.only(bottom:scrWidth*0.03),
                  child: TextFormField(
                    controller: apartmentController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                    cursorColor: colorConst.grey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 80),
                        labelText: "Apartment/House name",
                        labelStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            color: colorConst.grey),
                        filled: true,
                        fillColor: colorConst.white,
                        // hintText: "Enter your full name",
                        // hintStyle: TextStyle(
                        //     fontSize: scrWidth * 0.04,
                        //     fontWeight: FontWeight.w500,
                        //     color: colorConst.grey),
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
                Padding(
                  padding: EdgeInsets.only(bottom:scrWidth*0.03),
                  child: TextFormField(
                    controller: instructionsController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                    cursorColor: colorConst.grey,
                    decoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 80),
                        labelText: "Delivery Instructions",
                        labelStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            color: colorConst.grey),
                        filled: true,
                        fillColor: colorConst.white,
                        hintText: "e.g. Contact me if the Gate is closed",
                        hintStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            fontWeight: FontWeight.w500,
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
                SizedBox(height: scrHeight*0.04,),

                InkWell(
                  onTap: () {
                    if(
                    formKey.currentState!.validate()
                    ){
                      setState(() {
                        validate = true;
                      });
                      addaddress();
                      Navigator.pop(context);
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Valid details!")));
                    }
                  }
                  ,
                  child: Container(
                      height: scrHeight * 0.06,
                      decoration: BoxDecoration(
                        color: //validate?colorConst.meroon:
                        colorConst.meroon,
                        borderRadius: BorderRadius.circular(scrWidth * 0.07),
                      ),
                      child: Center(
                          child: Text("Add",
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
