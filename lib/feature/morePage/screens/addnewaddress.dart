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
  final List types;
  const addnewaddress(
      {super.key,required this.userName, required this.userNumber, required this.types});

  @override
  State<addnewaddress> createState() => _addnewaddressState();
}

class _addnewaddressState extends State<addnewaddress> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();

  String address = '';
  final emailValidation = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final phoneValidation = RegExp(r"[0-9]{10}");
  final pincodeValidation = RegExp(r"[0-9]{6}");

  final formKey = GlobalKey<FormState>();
  bool validate = false;
  bool otherAddress = false;
  var countryCode;
  UserModel? userModel;
  List newAddress=[];
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
      location: location,
      pincode: pincodeController.text,
      deliveryInstruction: instructionsController.text,
      buildingName: buildingNameController.text,
      street: streetController.text,
      town: townController.text,
      type: selectedAddressType,
    );

    await FirebaseFirestore.instance.collection("users").doc(loginId).get().then((value) {
      userModel = UserModel.fromMap(value.data()!);
    });
    newAddress=userModel!.address;
    newAddress.add(address.toMap());
    UserModel tempuserModel=userModel!.copyWith(
        address: newAddress
    );
    await FirebaseFirestore.instance.collection("users").doc(loginId).update(tempuserModel.toMap());
  }
  File? file;
  bool loading = false;
  String newImage = '';
  UserModel? usermodel;
  String location = '';
  var selectedAddressType;
  List addressTypes = [
    'Home', 'Work', 'Others'
  ];
  @override
  void initState() {
    //getUser();
    nameController.text = widget.userName;
    if(numberController.text.startsWith('+')){
      numberController.text = widget.userNumber.substring(3,13);
    }
    numberController.text = widget.userNumber;
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
              print(selectedAddressType);
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
                            if(!pincodeValidation.hasMatch(value!)){
                              return "Please enter valid pincode";
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
                            location = "${currentPosition.latitude},${currentPosition.longitude}";
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
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to load your Location"),
                              duration: Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                            ));
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
                            textCapitalization: TextCapitalization.words,
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
                            textCapitalization: TextCapitalization.words,
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
                    controller: buildingNameController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                    cursorColor: colorConst.grey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if(buildingNameController.text.isEmpty){
                        return "Please enter valid address";
                      }else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 80),
                        labelText: "Flat/House number, Building Name *",
                        labelStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            color: colorConst.grey),
                        filled: true,
                        fillColor: colorConst.white,
                        hintText: 'e.g. 12A, Metro Residency',
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
                  padding: EdgeInsets.only(bottom:scrWidth*0.03),
                  child: TextFormField(
                    controller: instructionsController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: scrWidth*0.03),
                  child: otherAddress?
                  SizedBox(
                    height: scrWidth*0.1,
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          hintText: "Save as",
                          suffixIcon: InkWell(
                              onTap: () {
                                otherAddress = false;
                                selectedAddressType = null;
                                setState(() {

                                });
                              },
                              child: Icon(Icons.close))
                      ),
                      onSubmitted: (value) {
                        if(widget.types.contains(value)){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$value address already exist'),
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ));
                          selectedAddressType = null;
                        }else{
                          selectedAddressType = value;
                        }
                        setState(() {

                        });
                      },
                    ),
                  ):
                  SizedBox(
                    height: scrWidth*0.1,
                    child: ListView.separated(
                      itemCount:addressTypes.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            Radio(
                              activeColor: colorConst.meroon,
                              value: addressTypes[index],
                              groupValue: selectedAddressType,
                              onChanged: (value) {
                                if(widget.types.contains(value)){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$value address already exist!'),
                                    duration: Duration(seconds: 1),
                                    behavior: SnackBarBehavior.floating,
                                  ));
                                  value = null;
                                }else if(value == "Others"){
                                  otherAddress = true;
                                } else {
                                  selectedAddressType = value;
                                }
                                setState(() {

                                });
                              },
                            ),
                            Text(addressTypes[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: scrWidth*0.035
                              ),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => SizedBox(width: 10,),


                    ),
                  ),
                ),
                SizedBox(height: scrWidth*0.1,),
                InkWell(
                  onTap: () {
                    if(
                    formKey.currentState!.validate() &&
                        selectedAddressType != null
                    ){
                      setState(() {
                        validate = true;
                      });
                      addaddress();
                      Navigator.pop(context);
                    }else{
                      selectedAddressType == null?
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Select Address Type!"),
                        duration: Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      )):
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Valid details!"),
                        duration: Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ));
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
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}